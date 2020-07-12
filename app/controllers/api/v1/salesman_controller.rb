module Api
  module V1
    class SalesmanController < ApplicationController
      before_action :salesman_params, only: [:create]

      def create
        result = salesman_service_create

        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          render_error(error: 'bad request', status: 400, msg: result.errors[:name])
        end
      end

      def update
        salesman = salesman_service_update

        if salesman.blank?
          render_error(error: 'Not found', status: 404)
        else
          render_error(error: 'ok', status: 200)
        end
      end

      private

      def salesman_service_create
        ::Services::Salesman::Create.new(params: salesman_params).call
      end

      def salesman_service_update
        ::Services::Salesman::Update.new(id: params[:id], update_params: salesman_params).call
      end

      def salesman_params

        if params[:salesman][:phone].blank?
          render_error
        end

        params.require(:salesman).permit(:name, :status, phone: [:number, :whatsapp])
      end

      def render_error(error: 'bad Request', status: 400, msg: '')
        render nothing: true, status: status, json: { status: status, data: error, msg: msg }
      end
    end
  end
end
