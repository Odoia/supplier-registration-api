require 'rails_helper'

describe '::Api::V1::SupplierController', type: :request do


  context 'When need register a supplier' do
    context 'When pass a valid params' do

      it 'shoud be return a http status 201' do
        post '/api/v1/supplier', params: { supplier: { cnpj: '123', fantasy_name: 'nome f', social_reason: 'social r' } }

        expect(response.status).to be 201
        expect((JSON.parse response.body)['data']['cnpj']).to eq '123'
        expect(::Supplier.count).to be 1
      end
    end
  end
end
