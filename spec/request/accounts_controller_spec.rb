require 'rails_helper'

RSpec.describe AccountsController, type: :request do

  describe "POST #create" do
    context "when a account is created" do
      it 'return 201 status code' do
        user = create(:user)
        account_params = attributes_for(:account, user_id: user.id)

        post "/accounts", params: { account: account_params }

        expect(response).to have_http_status(:created)
      end

      it 'must return a customer is created' do
        user = create(:user)
        account_params = attributes_for(:account, user_id: user.id)

        post "/accounts", params: { account: account_params }

        expect(json_body).to have_key(:name)
        expect(json_body).to have_key(:balance)
        expect(json_body).to have_key(:user)
        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
      end
    end
  end

  describe 'PUT #update' do
    context 'when pass valid data' do
      it 'return 200 status code' do
        account = create(:account)
        account_params = attributes_for(:account)

        put "/accounts/#{account.id}", params: { account: account_params }

        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'POST #deposit' do
    context 'with valid params' do
      it 'deposit into account' do
        account = create(:account)
        value = 200.5.to_f

        post "/accounts/#{account.id}/deposit", params: { value: value }

        expect(json_body[:mensage]).to eq('deposited')
      end
    end
  end

  describe 'POST #withdraw' do
    context 'with valid params' do
      it 'withdraw into account' do
        account = create(:account)
        value = 200.5.to_f

        post "/accounts/#{account.id}/withdraw", params: { value: value }

        expect(json_body[:mensage]).to eq('withdrawn')
      end
    end
  end

  describe 'GET #show' do
    context 'when find a account' do
      it 'return 200 status code' do
        account = create(:account)

        get "/accounts/#{account.id}"

        expect(response).to have_http_status(:ok)
      end

      it 'must return a balance' do
        account = create(:account)

        get "/accounts/#{account.id}"

        expect(json_body).to have_key(:balance)
      end
    end
  end
end
