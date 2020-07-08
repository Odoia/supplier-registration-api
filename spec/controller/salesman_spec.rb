require 'rails_helper'

describe ::Api::V1::SalesmanController, type: :controller do

  describe 'When need register a salesman' do
    context 'When pass a invalid params' do
      it 'shoud be return a http status 400' do
        post :create
        expect(response.status).to be 400
      end


      context 'When not pass a name' do

        it 'must be return a error name empty' do
          params = {
            status: 'ok',
          }

          post :create, params: { salesman: params }
          body = JSON.parse response.body
          expect(body['data']).to eq ["can't be blank"]
        end
      end

      xcontext 'quando passar um parametro a mais' do

        it 'espero que retorne parametros invalidos' do
          params = {
            name: 'joao',
            status: 'ok',
            name_2: 'tiago'
          }

          post :create, params: { salesman: params }

          body = JSON.parse response.body
          expect(response.status).to be 201
          expect(body['data']).not_to include 'tiago'
        end
      end
    end

    context 'When pass a valid params' do
      it 'count must be return 1 salesman' do
        params = {
            name: 'joao',
            status: 'ok'
        }

        post :create, params: { salesman: params }
        expect(::Salesman.count).to equal 1
      end

      it 'shoud be return a http status 201' do
        params = {
            name: 'joao',
            status: 'ok'
        }

        post :create, params: { salesman: params }
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
end
