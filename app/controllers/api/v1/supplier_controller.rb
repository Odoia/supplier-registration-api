module Api
  module V1
    class SupplierController < ApplicationController

      def create
        supplier = params['supplier']
        result = ::Supplier.new(
          cnpj: supplier['cnpj'],
          fantasy_name: supplier['fantasy_name'],
          social_reason: supplier['social_reason']
        )
        result.save
        render status: 201, json: { data: result, status: 201 }
      end

      def update
        result = supplier_service_update
        if result.nil?
          return render status: 404, json: { data: 'Not Found', status: 404 }
        end
        render status: 200, json: { data: result, status: 200 }
      end

      def supplier_service_update
        ::Services::Supplier::Update.new(id: params[:id], params: supplier_params).call
      end

      def supplier_params
        params.permit(
          :cnpj,
          :fantasy_name,
          :social_reason
        )
      end

    end
  end
end
