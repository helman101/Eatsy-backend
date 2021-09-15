require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:foods) { create_list(:food, 5) }
  let!(:users) { create_list(:user, 5) }
  let!(:orders) { create_list(:order, 5, customer_id: users.first.id, food_id: foods.first.id) }
  let(:order_id) { Order.first.id }

  describe 'GET /orders' do
    before { get '/orders' }

    it 'returns order' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /orders/:id' do
    before { get "/orders/#{order_id}" }

    context 'when the order exist' do
      it 'returns the order' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(order_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the order doesn\'t exist' do
      let(:order_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/order not found/)
      end
    end
  end

  describe 'POST /orders' do
    let(:correct_attributes) do
      { order: { customer_id: users.first.id, food_id: foods.first.id, delivered: false } }
    end

    context 'when the order is valid' do
      before { post '/orders', params: correct_attributes }

      it 'creates an order' do
        expect(json['data']['customer_id']).to eq(users.first.id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the order is invalid' do
      before { post '/orders', params: { order: { food_id: 1, delivered: true } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return a validation failure message' do
        expect(response.body)
          .to match(/order not save/)
      end
    end
  end

  describe 'DELETE /orders/:id' do
    before { delete "/orders/#{order_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end

    it 'returns a confirm message' do
      expect(response.body).to match(/Deleted order/)
    end
  end
end