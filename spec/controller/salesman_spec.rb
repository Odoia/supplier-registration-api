require 'rails_helper'

describe ::Api::V1::SalesmanController, type: :controller do

  describe 'When need register a salesman' do
    context 'When pass a invalid params' do

      it 'shoud be return a http status 400 when params is empty' do
        params = {
          name: '',
          status: '',
          phone: ''
        }

        post :create, params: { salesman: params }
        expect(response.status).to be 400
      end

      it 'shoud be return a http status 400 when phone don`t exist' do
        params = {
          name: '',
          status: ''
        }

        post :create, params: { salesman: params }
        expect(response.status).to be 400
      end

      context 'When not pass a name' do
        it 'must be return a error name empty' do
          params = {
            name: '',
            status: 'ok',
            phone: [
              { number: '8288776501', whatsapp: true }
            ]
          }

          post :create, params: { salesman: params }
          body = JSON.parse response.body
          expect(body['msg']).to eq ["can't be blank"]
        end
      end

      xcontext 'When not pass a phone' do
        it 'must be return a error phone empty' do
          params = {
            name: 'name',
            status: 'ok'
          }

          post :create, params: { salesman: params }
          body = JSON.parse response.body
          expect(body['data']).to eq ["can't be blank"]
        end
      end
    end

    context 'When pass a valid params' do
      it 'count must be return 1 salesman with 2 whatsapp numbers and 1 normal phone' do
        params = {
          name: 'joao',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true },
            { number: '8288776502', whatsapp: true },
            { number: '8288776503', whatsapp: false }
          ]
        }

        post :create, params: { salesman: params }
        expect(::Salesman.count).to equal 1
        expect(::Phone.count).to equal 3
      end

      it 'shoud be return a http status 201' do
        params = {
          name: 'joao',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true },
            { number: '8288776502', whatsapp: true },
            { number: '8288776503', whatsapp: false }
          ]
        }

        post :create, params: { salesman: params }
        expect(response.status).to be 201
      end

      it 'shoud be return created salesman with phone' do
        params = {
          name: 'joao',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true },
            { number: '8288776502', whatsapp: true },
            { number: '8288776503', whatsapp: false }
          ]
        }

        post :create, params: { salesman: params }
        body = JSON.parse response.body
        expect(body['data']['name']).to eq 'joao'
        expect(body['data']['phones'].first['number']).to eq '8288776501'
        expect(body['data']['phones'].first['whatsapp']).to eq true
        expect(body['data']['phones'].second['number']).to eq '8288776502'
        expect(body['data']['phones'].second['whatsapp']).to eq true
        expect(body['data']['phones'].third['number']).to eq '8288776503'
        expect(body['data']['phones'].third['whatsapp']).to eq false
      end
    end
  end
end
