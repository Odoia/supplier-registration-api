require 'rails_helper'

describe '::Api::V1::SalesmanController', type: :request do
  describe 'When need update a salesman' do
    context 'when request attributes are valid' do
      it 'Should return status code 200' do
        params = {
          name: 'joao updated',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true }
          ]
        }
        post '/api/v1/salesman', params: { salesman: params }

        body = JSON.parse response.body

        put "/api/v1/salesman/#{body['data']['id']}", params: { salesman: params }
        expect(response).to have_http_status(200)
      end

      it 'Should return updated object' do
        params = {
          name: 'joao created',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true }
          ]
        }

        params_update = {
          name: 'joao updated',
          status: 'ok'
        }

        post '/api/v1/salesman', params: { salesman: params }

        body = JSON.parse response.body

        put "/api/v1/salesman/#{body['data']['id']}", params: { salesman: params_update }

        expect({ name: body['data']['name'], status: body['data']['status'] }).to match({ name: params[:name], status: params[:status] })
      end
    end

    context 'When the salesman does not exist' do
      it 'Should return http status 404' do
        params = {
          name: 'Teste',
          status: 'ok',
          id: 50
        }

        put '/api/v1/salesman/100', params: { salesman: params }

        expect(response.status).to eql 404
      end

      it 'Should return a not found message' do
        params = {
          name: 'joao created',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true }
          ]
        }

        params_update = {
          name: 'joao updated',
          status: 'ok'
        }

        salesman = post '/api/v1/salesman', params: { salesman: params }
        id = salesman + 1
        put "/api/v1/salesman/#{id}", params: { salesman: params_update }

        body = JSON.parse response.body
        expect(body['data']).to eql 'Not Found'
      end
    end
  end
  describe 'When need add the phone the of salesman' do

    context 'When request attributes are valid for add a phone' do
      it 'Should add one phone and return status code 201' do

        params = {
          phone: [
            { number: '8288776501', whatsapp: true }
          ]
        }

        salesman_id = 1

        post "/api/v1/salesman/#{salesman_id}/add-phone", params: { salesman: params }

        expect(response.status).to eql 201

      end

    end

    context 'When request attributes are invalid for add a phone' do
      it 'should return a bad request when phone is null' do

        params = {
          phone: []
        }

        post '/api/v1/salesman/1/add-phone', params: { salesman: params }
        body = JSON.parse response.body
        expect(body['data']).to eq 'Bad Request'

      end
    end

  end
  describe 'When need disable the phone the of salesman' do

    context 'When request attributes are valid for disable a phone ' do

      it 'Should disable a phone and return status code 200' do

        params = {
          name: 'joao created',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true },
            { number: '8288776502', whatsapp: true }
          ]
        }
        post '/api/v1/salesman', params: { salesman: params }

        body = JSON.parse response.body
        phone_id = body['data']['phones'][0]['id']

        put "/api/v1/salesman/#{body['data']['id']}/disable-phone/#{phone_id}"

        expect(response.status).to eql 200

      end
    end
    context 'When request attributes are invalid for disable a phone' do


      it 'should return a not found message when phone not exists' do

        params = {
          name: 'joao created',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true },
            { number: '8288776501', whatsapp: true }
          ]
        }
        post '/api/v1/salesman', params: { salesman: params }

        body_salesman = JSON.parse response.body
        saleman_id = body_salesman['data']['id']
        phone_id = body_salesman['data']['phones'][0]['id'] + 2

        put "/api/v1/salesman/#{saleman_id}/disable-phone/#{phone_id}"
        body_phone = JSON.parse response.body

        expect(body_phone['data']).to eql 'Not Found'

      end

      it 'Should return a message error when disable the number whatssapp unique of salesman'  do

        params = {
          name: 'joao created',
          status: 'ok',
          phone: [
            { number: '8288776501', whatsapp: true }
          ]
        }
        post '/api/v1/salesman', params: { salesman: params }

        body_salesman = JSON.parse response.body
        saleman_id = body_salesman['data']['id']
        phone_id = body_salesman['data']['phones'][0]['id']

        put "/api/v1/salesman/#{saleman_id}/disable-phone/#{phone_id}"
        body_phone = JSON.parse response.body

        expect(body_phone['data']).to eql 'Salesman must have at least one number whatsapp'


      end

    end
  end
end
