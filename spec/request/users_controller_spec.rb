require 'rails_helper'

RSpec.describe UsersController, type: :request do

  describe "POST #create" do
    context "when a users is created" do
      it 'return 201 status code' do
        user_params = attributes_for(:user)

        post "/users", params: { user: user_params }

        expect(response).to have_http_status(:created)
      end

      it 'must return a users is created' do
        user_params = attributes_for(:user)

        post "/users", params: { user: user_params }

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
      end
    end
  end
end
