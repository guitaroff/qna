require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/profiles/me', params: { format: :json, access_token: '12345' }
        expect(response.status).to eq 401
      end
    end

    it 'test' do
      expect(FactoryBot.build(:access_token)).to be_valid
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:application) { Doorkeeper::Application.create!(name: 'Test', redirect_uri: 'urn:ietf:wg:oauth:2.0:oob', uid: '123456789', secret: '987654321') }
      let!(:access_token) { Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: me.id, scopes: 'public') }
      
      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        puts "BODY: #{response.body}"
        expect(response).to be_success
      end

      it 'contains email' do
        expect(response.body).to be_json_eql(me.email.to_json).at_path('email')
      end

      it 'contains id' do
        expect(response.body).to be_json_eql(me.id.to_json).at_path('id')
      end

      it 'does not contain password' do
        expect(response.body).to_not have_json_path('password')
      end

      it 'does not contain encrypted_password' do
        expect(response.body).to_not have_json_path('encrypted_password')
      end
    end
  end
end
