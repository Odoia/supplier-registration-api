module Api
  module V1
    class SupplierController < ApplicationController

      def create
        supplier =  params['supplier']
        result = ::Supplier.new(
          cnpj: supplier['cnpj'],
          fantasy_name: supplier['fantasy_name'],
          social_reason: supplier['social_reason']
        )
        result.save
        render status: 201, json: { data: result, status: 201 }
      end

      def update
        result = ::Supplier.find_by(id: params['id'])
        result.update(
          cnpj: params['cnpj'],
          fantasy_name: params['fantasy_name'],
          social_reason: params['social_reason']
        )
        result.save
        render status: 200, json: { data: result, status: 200 }
      end
    end
  end
end
