require 'rails_helper'

describe '::Api::V1::SupplierController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:url) { '/api/v1/supplier' }

  let(:execute_actions) {}

  let(:create_2_supplier) do
    post url, params: { supplier: valid_params }
    post url, params: { supplier: valid_params }
  end

  let(:valid_params) do

    { 
      cnpj: Faker::Number.number,
      fantasy_name: Faker::Name.name,
      social_reason: Faker::Creature::Dog.name,
    }
  end

  let(:body) { JSON.parse response.body }

  describe 'When get all supplier' do
    context 'When get more then one' do
      let(:execute_actions) do
        create_2_supplier
        get url
      end

      it 'shoud be return a http status 200' do
        expect(response.status).to be 200
      end

      it 'shoud be return a array with count == 2' do
        expect(body["data"].count).to be 2
      end
    end

    context 'When no have a supplier registered' do
      let(:execute_actions) do
        get url
      end

      it 'should be return a empty array' do
        expect(body["data"].count).to be 0
      end
    end
  end
end
