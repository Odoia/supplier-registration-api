require 'rails_helper'

describe ::Api::V1::SalesmanController, type: :controller do

  describe 'When need register a salesman' do
    context 'When pass a invalid params' do
      it 'shoud be return a http status 400' do
        post :create
        expect(response.status).to be 400
      end
    end

    context 'When pass a valid params' do

      it 'count must be return 1 salesman' do
        params = {
            name: 'joao',
            status: 'ok'
        }

        post :create, params: params
        expect(::Salesman.count).to equal 1
      end

      it 'shoud be return a http status 201' do
        params = {
            name: 'joao',
            status: 'ok'
        }

        post :create, params: params
        expect(response.status).to be 201
      end

      it 'shoud be return created salesman' do
        params = {
            name: 'joao',
            status: 'ok'
        }

        post :create, params: params
        body = JSON.parse response.body
        expect(body['data']['name']).to eq 'joao'
      end
    end
  end

  describe 'When need update a salesman' do

    context 'when request attributes are valid' do
      it 'should return status code 200' do
        params = {
            name: 'joao updated',
            status: 'ok'
        }
        salesman = ::Salesman.create(params)

        put "api/vi/salesman/#{salesman.id}", params:params
        expect(response).to have_http_status(200)
      end

      it 'should return updated object' do
        params = {
            name: 'joao updated',
            status: 'ok'
        }
        salesman = ::Salesman.create(params)
        put "api/vi/salesman/#{salesman.id}", params:params
        expect(salesman.reload).to have_attributes(params)
      end

    end

    context 'when the salesman does not exist' do

      it 'should return http status 404' do
        params = {name: 'Teste', status: 'ok', id: 50}
        salesman_id = 100
        put "salesman/#{salesman_id}", params:params

        expect(response.status).to eql 404
      end

      it 'should return a not found message' do
        params = {name: 'Teste', status: 'ok', id: 50}
        salesman_id = 100
        put "/api/vi/salesman/#{salesman_id}", params:params
        body = JSON.parse response.body
        expect(body['data']).to eql 'Not Found'
      end

    end

  end
end
