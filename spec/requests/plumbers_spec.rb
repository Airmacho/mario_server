require 'rails_helper'

RSpec.describe "Plumbers", type: :request do
  describe "GET /jobs" do
    let!(:plumber_mario) { create(:plumber_mario) }
    let!(:client_peach) { create(:client_peach) }

    context 'when query with valid parameters' do
      before do 
        now = Time.now
        @job1 = create(:job_allocated, { plumber: plumber_mario, client: client_peach, started_at: now })
        @job2 = create(:job_allocated, { plumber: plumber_mario, client: client_peach, started_at: now })
        @job3 = create(:job_allocated, { plumber: plumber_mario, client: client_peach, started_at: now - 3.days })
        @job4 = create(:job_completed, { plumber: plumber_mario, client: client_peach, started_at: now + 5.hours })
      end
      it "renders a successful response" do
        now = Time.now
        get plumber_jobs_url(starts_at: now - 1.days, ends_at: now + 1.days, plumber_id: plumber_mario.id), headers: {}, as: :json
        expect(response).to be_successful
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['plumber_id']).to eq plumber_mario.id
        expect(parsed_body['jobs'].size).to eq 3
        last_job = parsed_body['jobs'].last
        nested_client = last_job['client']
        expect(nested_client['client_id']).to eq client_peach.id
        expect(nested_client['private_note']).to be nil
        expect(nested_client['name']).to eq client_peach.name
        expect(nested_client['age']).to eq client_peach.age
        expect(nested_client['address']).to eq client_peach.address
      end
    end
  end
end
