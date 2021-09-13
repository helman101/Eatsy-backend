require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:users) { create_list(:user, 5) }
  let(:user_id) { User.first.id }

  describe 'GET /users' do
    before { get '/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json['users'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{user_id}" }

    context 'when the user exist' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['user']['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user doesn\'t exist' do
      let(:user_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/user not found/)
      end
    end
  end

  describe 'POST /users' do
    let(:correct_attributes) do
      { user: { name: 'Alfred', email: 'admin@test.com', password: '1234', password_confirmation: '1234' } }
    end

    context 'when the user is valid' do
      before { post '/users', params: correct_attributes }

      it 'creates a user' do
        expect(json['user']['name']).to eq('Alfred')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the user is invalid' do
      before { post '/users', params: { user: { name: 'Admin', password: '1234' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return a validation failure message' do
        expect(response.body)
          .to match(/Email can't be blank/)
      end
    end
  end

  describe 'GET /login' do
    let(:user_email) { users.first.email }
    let(:user_password) { users.first.password }
    before { get "/login?#{{user: { email: user_email, password: user_password }}.to_query}" }

    context 'when the user exist' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['user']['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user doesn\'t exist' do
      let(:user_email) { '1234' }

      it 'returns status code 404' do
        expect(response).to have_http_status(200)
      end

      it 'returns status no exist' do
        expect(response.body).to match(/User doesn't exist/)
      end
    end

    context 'when password is wrong' do
      let(:user_password) { 'wrong' }

      it 'returns status code 404' do
        expect(response).to have_http_status(200)
      end

      it 'returns exist message' do
        expect(response.body).to match(/Wrong Password/)
      end
    end
  end
end