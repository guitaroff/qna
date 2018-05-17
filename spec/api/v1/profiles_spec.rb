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
      let(:access_token) { create(:access_token) }
      
      it 'returns 200 status' do
        #puts "access_token: #{access_token}"
        get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token }
        expect(response).to be_success
      end
    end
  end
end
