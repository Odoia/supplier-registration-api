require 'rails_helper'

describe ::Api::V1::SalesmanController, type: :controller do

  context 'When need register a salesman' do
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
end
