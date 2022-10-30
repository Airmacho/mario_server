require 'rails_helper'

RSpec.describe "/jobs", type: :request do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let!(:plumber_mario) { create(:plumber_mario) }
  let!(:plumber_luigi) { create(:plumber_luigi) }
  let!(:client_peach) { create(:client_peach) }
  

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    context "when query currently allocated jobs in a date period" do
      before do
        now = Time.now
        @job1 = create(:job_allocated, { plumber: plumber_mario, client: client_peach, started_at: now })
        @job2 = create(:job_allocated, { plumber: plumber_luigi, client: client_peach, started_at: now })
        @job3 = create(:job_allocated, { plumber: plumber_mario, client: client_peach, started_at: now - 3.days })
        @job4 = create(:job_allocated, { plumber: plumber_mario, client: client_peach, started_at: now + 3.days })
      end

      it "should return empty jobs if query without query_date param" do
        get jobs_url, headers: valid_headers, as: :json
        expect(response).to be_bad_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to be_empty
      end

      it "should return empty jobs if query with empty query_date param" do
        get jobs_url(query_date: nil), headers: valid_headers, as: :json
        expect(response).to be_bad_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to be_empty
      end

      it "should return empty jobs if query with invalid query_date param" do
        get jobs_url(query_date: 'invalid strftime'), headers: valid_headers, as: :json
        expect(response).to be_bad_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to be_empty
      end

      it "should renders a successful response and return jobs with allocated status and started_at within the date" do
        get jobs_url(status: 'allocated', query_date: Time.now.to_date), headers: valid_headers, as: :json
        expect(response).to be_successful
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.size).to equal(2)
        data_ids = parsed_body.map {|e| e['id']}
        expect(data_ids).to include @job1.id
        expect(data_ids).to include @job2.id
        returned_job = parsed_body.last
        expect(returned_job['started_at']).not_to be_nil
        expect(returned_job['client_id']).not_to be_nil
        expect(returned_job['plumber_id']).not_to be_nil
      end
    end
  end

  describe "POST /create" do
    before do
      job_started_at = Time.now + 1.day
      @valid_job_params = {
        plumber_ids: [plumber_mario.id, plumber_luigi.id],
        client_id: client_peach.id,
        started_at: job_started_at
      }
    end
    context "when request with valid parameters" do
      it "creates multiple jobs belongs to one client" do
        expect {
          post jobs_url,
               params: @valid_job_params, headers: valid_headers, as: :json
        }.to change(Job, :count).by(2)
        expect(response).to be_successful
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.size).to equal 2
        new_job = parsed_body.last
        expect(new_job['id']).not_to be_nil
        expect(new_job['started_at']).not_to be_nil
        expect(new_job['plumber_id']).not_to be_nil
        expect(new_job['client_id']).to eq @valid_job_params[:client_id]
      end
    end

    context "when request with invalid parameters" do
      it "should does not create any jobs with empty plumber_ids" do
        # deliberately mess up valid params
        invalid_job_params = @valid_job_params.merge(plumber_ids: [])
        expect {
          post jobs_url,
               params: { job: invalid_job_params }, as: :json
        }.to change(Job, :count).by(0)
        expect(response).to be_unprocessable
        expect(response.body).to eq 'required parameters missing'
      end

      it "should does not create any jobs with invalid plumber_ids" do
        # deliberately mess up valid params
        invalid_job_params = @valid_job_params.merge(plumber_ids: [101, 102])
        expect {
          post jobs_url,
               params: invalid_job_params, as: :json
        }.to change(Job, :count).by(0)
        expect(response).to be_unprocessable
        expect(response.body).to eq 'plumbers with id [101, 102] not found'
      end

      it "should does not create any jobs with invalid client_id" do
        # deliberately mess up valid params
        invalid_job_params = @valid_job_params.merge(client_id: 1001)
        expect {
          post jobs_url,
               params: invalid_job_params, as: :json
        }.to change(Job, :count).by(0)
        expect(response).to be_unprocessable
        expect(response.body).to eq 'client not found'
      end

      it "should does not create any jobs with invalid client_id" do
        # deliberately mess up valid params
        invalid_job_params = @valid_job_params.merge(client_id: 1001)
        expect {
          post jobs_url,
               params: invalid_job_params, as: :json
        }.to change(Job, :count).by(0)
        expect(response).to be_unprocessable
        expect(response.body).to eq 'client not found'
      end
    end
  end

  describe "PATCH /complete" do
    context "with valid parameters" do
      before do
        @my_job = create(:job_allocated, plumber: create(:plumber_mario), client: create(:client_peach))
        @others_job = create(:job_allocated, plumber: create(:plumber_luigi), client: create(:client_peach))
      end
      # let(:job_complete_params) {
      #   {
      #     plumber_id: 
      #   }
      # }

      it "should set the status as completed when current status is allocated" do
        expect(@my_job.status_allocated?).to be true
        expect(@my_job.finished_at).to be nil
        # job = Job.create! valid_attributes
        patch job_complete_url(@my_job),
              params: { plumber_id: @my_job.plumber_id, id: @my_job.id }, headers: valid_headers, as: :json
        @my_job.reload
        expect(@my_job.status_completed?).to be true
        expect(@my_job.finished_at).not_to be nil
      end

      it "renders a JSON response with the job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested job" do
      job = Job.create! valid_attributes
      expect {
        delete job_url(job), headers: valid_headers, as: :json
      }.to change(Job, :count).by(-1)
    end
  end
end
