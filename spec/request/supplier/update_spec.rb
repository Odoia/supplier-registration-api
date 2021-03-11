require 'rails_helper'

describe '::Api::V1::SupplierController', type: :request do


  context 'When need update a supplier' do
    context 'When pass a valid params' do

      it 'shoud be return a http status 200' do
        post '/api/v1/supplier', params: { supplier: { cnpj: '123', fantasy_name: 'nome f', social_reason: 'social r' } }

        put "/api/v1/supplier/#{Supplier.first.id}", params: { cnpj: '000', fantasy_name: 'f_name', social_reason: 's_reason' }

        result = JSON.parse response.body
        expect(response.status).to be 200
        expect(result['data']['cnpj']).to eq '000'
        expect(result['data']['fantasy_name']).to eq 'f_name'
        expect(result['data']['social_reason']).to eq 's_reason'
      end
    end

    context 'When pass a invalid params' do

      it 'should be return a http status 404 when supplier not exist' do
        post '/api/v1/supplier', params: { supplier: { cnpj: '123', fantasy_name: 'nome f', social_reason: 'social r' } }

        put "/api/v1/supplier/10", params: { cnpj: '000', fantasy_name: 'f_name', social_reason: 's_reason' }

        result = JSON.parse response.body
        expect(response.status).to be 404
        expect(result['data']).to eq 'Not Found'
      end

    end

  end
end
