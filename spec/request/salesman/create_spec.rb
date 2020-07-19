require 'rails_helper'

describe '::Api::V1::SalesmanController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:url) { '/api/v1/salesman' }

  let(:execute_actions) {}

  let(:invalid_params) do
    {
      name: '',
      status: ''
    }
  end

  let(:invalid_params_without_name) do
    {
      name: '',
      status: 'ok',
      phone: [
        { number: '8288776501', whatsapp: true }
      ]
    }
  end

  let(:valid_params) do
    {
      name: 'joao',
      status: 'ok',
      phone: [
        { number: '8288776501', whatsapp: true },
        { number: '8288776502', whatsapp: true },
        { number: '8288776503', whatsapp: false }
      ]
    }
  end

  let(:body) { JSON.parse response.body }

  describe 'When need register a salesman' do
    context 'When pass a invalid params' do
      let(:execute_actions) do
        post url, params: { salesman: invalid_params }
      end

      it 'shoud be return a http status 400 when params is empty' do
        expect(response.status).to be 400
      end

      context 'When not pass a name' do
        let(:execute_actions) do
          post url, params: { salesman: invalid_params_without_name }
        end

        it 'must be return a error name empty' do
          expect(body['msg']).to eq ["can't be blank"]
        end
      end
    end

    context 'When pass a valid params' do
      let(:execute_actions) do
        post url, params: { salesman: valid_params }
      end

      it 'count must be return 1 salesman with 2 whatsapp numbers and 1 normal phone' do
        expect(::Salesman.count).to equal 1
        expect(::Phone.count).to equal 3
      end

      it 'shoud be return a http status 201' do
        expect(response.status).to be 201
      end

      it 'shoud be return created salesman with phone' do
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
