require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  let!(:foods) { create_list(:food, 5) }
  let(:food_id) { Food.first.id }

  describe 'GET /foods' do
    before { get '/foods' }

    it 'returns order' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /foods/:id' do
    before { get "/foods/#{food_id}" }

    context 'when the food exist' do
      it 'returns the food' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(food_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the food doesn\'t exist' do
      let(:food_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/food not found/)
      end
    end
  end

  describe 'POST /foods' do
    let(:correct_attributes) do
      { food: { name: 'Apple', price: 15, description: 'Red fruit' } }
    end

    context 'when the order is valid' do
      before { post '/foods', params: correct_attributes }

      it 'creates an order' do
        expect(json['data']['name']).to eq('Apple')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the order is invalid' do
      before { post '/foods', params: { food: { price: 15, description: 'Red fruit' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return a validation failure message' do
        expect(response.body)
          .to match(/food not save/)
      end
    end
  end

  describe 'DELETE /foods/:id' do
    before { delete "/foods/#{food_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end

    it 'returns a confirm message' do
      expect(response.body).to match(/Deleted food/)
    end
  end
end