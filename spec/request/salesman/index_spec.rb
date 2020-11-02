require 'rails_helper'

describe '::Api::V1::SalesmanController', type: :request do

  before do
    I18n.default_locale = :en
    execute_actions
  end

  let(:url) { '/api/v1/salesman' }

  let(:execute_actions) {}

  let(:create_2_salesman) do
    post url, params: { salesman: valid_params }
    post url, params: { salesman: valid_params }
  end

  let(:valid_params) do
    {
      name: Faker::Name.name,
      status: Faker::Name.name,
      phones: [
        { number: Faker::PhoneNumber.cell_phone, whatsapp: true },
        { number: Faker::PhoneNumber.cell_phone, whatsapp: true },
        { number: Faker::PhoneNumber.cell_phone, whatsapp: false }
      ]
    }
  end

  let(:body) { JSON.parse response.body }

  describe 'When get all salesman' do
    context 'When get more then one' do
      let(:execute_actions) do
        create_2_salesman
        get url
      end

      it 'shoud be return a http status 200' do
        expect(response.status).to be 200
      end

      it 'shoud be return a array with count == 2' do
        expect(body["data"].count).to be 2
      end
    end

    context 'When no have a salesman registered' do
      let(:execute_actions) do
        get url
      end

      it 'should be return a empty array' do
        expect(body["data"].count).to be 0
      end
    end
  end
end
