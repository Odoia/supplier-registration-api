require 'rails_helper'

describe '::Api::V1::SalesmanController', type: :request do
  describe 'When need update a salesman' do
    context 'when request attributes are valid' do
      it 'should return status code 200' do
        params = {
          name: 'joao updated',
          status: 'ok'
        }
        salesman = ::Salesman.create(params)

        put "/api/v1/salesman/#{salesman.id}", params: { salesman: params }
        expect(response).to have_http_status(200)
      end

      it 'should return updated object' do
        params = {
          name: 'joao updated',
          status: 'ok'
        }
        salesman = ::Salesman.create(params)
        put "/api/v1/salesman/#{salesman.id}", params: { salesman: params }
        expect(salesman.reload).to have_attributes(params)
      end
    end

    context 'when the salesman does not exist' do
      it 'should return http status 404' do
        params = { name: 'Teste', status: 'ok', id: 50 }

        put '/api/v1/salesman/100', params: { salesman: params }

        expect(response.status).to eql 404
      end

      it 'should return a not found message' do
        params = {
          name: 'joao updated',
          status: 'ok'
        }
        salesman = ::Salesman.create(params)
        id = salesman.id + 1
        put "/api/v1/salesman/#{id}", params: { salesman: params }

        body = JSON.parse response.body
        expect(body['data']).to eql 'Not Found'
      end
    end
  end
end
