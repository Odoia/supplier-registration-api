module Api
  module V1
    class SupplierController < ApplicationController
      before_action :supplier_params, only: [:create]

      def create
        result = create_supplier
        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          errors = result.errors.messages.map { |k,v| "#{k} #{v.first}" }.flatten
          render_error(msg: errors)
        end
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

      private

      def create_supplier
        ::Services::Supplier::Create.new(params: supplier_params).call
      end

      def supplier_params
        return render_error if params['supplier'].blank?

        params.require(:supplier).permit(
          :cnpj, :fantasy_name, :social_reason
        )
      end

      def render_error(error: I18n.t('bad_request'), status: 400, msg: '')
        render nothing: true, status: status, json: { status: status, data: error, msg: msg } 
      end
    end
  end
end
