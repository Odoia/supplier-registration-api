require 'rails_helper'

describe '::Api::V1::SalesmanController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:url) { '/api/v1/salesman' }

  let(:execute_actions) {}

  let(:body) { JSON.parse response.body }

  let(:valid_params_create) do
    {
      name: Faker::Name.name,
      status: Faker::Name.name,
      phones: [
        { number: Faker::PhoneNumber.cell_phone, whatsapp: true },
        { number: Faker::PhoneNumber.cell_phone, whatsapp: true }
      ]
    }
  end

  let(:valid_params_update) do
    {
      name: Faker::Name.name,
      status: Faker::Name.name
    }
  end

  let(:valid_params_phone) do
    {
      phones: [
        { number: Faker::PhoneNumber.cell_phone, whatsapp: true }
      ]
    }
  end

  describe 'When need update a salesman' do

    context 'when request attributes are valid' do
      let(:execute_actions) do
        post url, params: { salesman: valid_params_create }
      end

      it 'Should return status code 200' do

        put "#{url}/#{body['data']['id']}", params: { salesman: valid_params_update }
        expect(response).to have_http_status(200)
      end
    end

    context 'When the salesman does not exist' do
      let(:execute_actions) do
        post url, params: { salesman: valid_params_create }
      end

      it 'Should return http status 404' do

        put "#{url}/100", params: { salesman: valid_params_update }

        expect(response.status).to eql 404
      end

      it 'Should return a not found message' do

        id = body['data']['id'] + 1
        put "#{url}/#{id}", params: { salesman: valid_params_update }

        body_update = JSON.parse response.body
        expect(body_update['data']).to eql 'Not Found'
      end
    end

    context 'When need add the phone the of salesman' do
      context 'When request attributes are valid for add a phone' do
        let(:execute_actions) do
          salesman_id = 1
          post "#{url}/#{salesman_id}/add-phone", params: { phones: valid_params_phone }
        end

        it 'Should add one phone and return status code 201' do
          expect(body['status']).to eql 201
        end
      end

      context 'When request attributes are invalid for add a phone' do
        let(:execute_actions) do
          post url, params: { salesman: valid_params_create }
        end

        it 'should return a bad request when phone is null' do

          params = {
            phones: []
          }

          
          post "#{url}/1/add-phone", params: { phones: params }
          body = JSON.parse response.body
          expect(body['data']).to eq 'Bad Request'

        end
      end

    end

    describe 'When need disable the phone the of salesman' do

      context 'When request attributes are valid for disable a phone ' do
        let(:execute_actions) do
          post url, params: { salesman: valid_params_create }
        end

        it 'Should disable a phone and return status code 200' do

          phone_id = body['data']['phones'][0]['id']

          put "#{url}/#{body['data']['id']}/disable-phone/#{phone_id}"

          expect(response.status).to eql 200

        end
      end

      context 'When request attributes are invalid for disable a phone' do
        let(:execute_actions) do
          post url, params: { salesman: valid_params_create }
        end

        it 'should return a not found message when phone not exists' do

          saleman_id = body['data']['id']
          phone_id = body['data']['phones'][0]['id'] + 2

          put "#{url}/#{saleman_id}/disable-phone/#{phone_id}"
          body_phone = JSON.parse response.body

          expect(body_phone['data']).to eql 'Not Found'

        end

        it 'Should return a message error when disable the number whatssapp unique of salesman' do

          params = {
            name: Faker::Name.name,
            status: Faker::Name.name,
            phone: [
              { number: Faker::PhoneNumber.cell_phone, whatsapp: true }
            ]
          }
          post "#{url}", params: { salesman: params }

          body_salesman = JSON.parse response.body
          saleman_id = body_salesman['data']['id']
          phone_id = body_salesman['data']['phones'][0]['id']

          put "#{url}/#{saleman_id}/disable-phone/#{phone_id}"
          body_phone = JSON.parse response.body

          expect(body_phone['data']).to eql 'Salesman must have at least one number whatsapp'
        end
      end
    end
  end
end
