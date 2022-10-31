require 'rails_helper'

RSpec.describe "/clients", type: :request do
  describe "POST /create" do
    before do
      @client_params = {
        name: 'Princess Peach',
        age: 16,
        private_note: 'nice and shine',
        address: 'Mushroom Kingdom'
      }
    end

    context "with valid parameters" do
      it "creates a new Client" do
        expect {
          post clients_url,
               params: @client_params, headers: {}, as: :json
        }.to change(Client, :count).by(1)
      end

      it "renders a JSON response with the new client" do
        post clients_url,
             params: @client_params, headers: {}, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested client" do
      client = create(:client_peach)
      expect {
        delete client_url(client), headers: {}, as: :json
      }.to change(Client, :count).by(-1)
    end
  end
end
