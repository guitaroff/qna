require 'rails_helper'

describe 'Questions API' do
  describe 'GET /index' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/questions', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/questions', params: { format: :json, access_token: '12345' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let!(:application) { Doorkeeper::Application.create!(name: 'Test', redirect_uri: 'urn:ietf:wg:oauth:2.0:oob', uid: '123456789', secret: '987654321') }
      let!(:access_token) { Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: user.id, scopes: 'public') }

      it 'returns 200 status code' do
        get '/api/v1/questions', params: { format: :json, access_token: access_token.token }
        expect(response).to be_success
      end
    end
  end
end
