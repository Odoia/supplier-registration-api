module Api
  module V1
    class SalesmanController < ApplicationController
      before_action :salesman_params, only: [:create]

      def index
        result = Salesman.all
       render status: 200, json: { data: result, status: 200 }
      end

      def create
        result = salesman_service_create

        unless result.id.nil?
          render status: 201, json: { data: result, status: 201 }
        else
          render_error(error: I18n.t('bad_request'), status: 400, msg: result.errors[:name])
        end
      end

      def update
        salesman = salesman_service_update

        if salesman.blank?
          render_error(error: I18n.t('not_found'), status: 404)
        else
          render status: 200
        end
      end

      def add_phone
        result = phone_service_create

        if result.blank?
          render_error(error: I18n.t('bad_request'), status: 400)
        else
          render status: 201, json: { data: result, status: 201 }
        end
      end

      def disable_phone

        result = phone_service_disable

        if result.blank?
          render_error(error: I18n.t('not_found'), status: 404)

        elsif result[:errors]
          render_error(error: result[:errors], status: 404)
        else
          render status: 200, json: { data: result, status: 200 }
        end

      end

      private

      def salesman_service_create
        ::Services::Salesman::Create.new(params: salesman_params).call
      end

      def salesman_service_update
        ::Services::Salesman::Update.new(id: params[:id], update_params: salesman_params_update).call
      end

      def phone_service_create
        ::Services::Phone::Create.new(params: salesman_params_phone[:phones], salesman_id: params[:id]).call
      end

      def phone_service_disable
        ::Services::Phone::Disable.new(salesman_id: params[:salesman_id], phone_id: params[:phone_id]).call
      end


      def salesman_params

        if params[:salesman][:phones].blank?
          render_error
        end

        params.require(:salesman).permit(:name, :status, phones: [:number, :whatsapp])
      end

      def salesman_params_update

        params.require(:salesman).permit(:name, :status)
      end

      def salesman_params_phone
        if params[:phones].blank?
          render_error
        end

        params.require(:phones).permit(phones: [:number, :whatsapp])
      end

      def render_error(error: I18n.t('bad_request'), status: 400, msg: '')
        render nothing: true, status: status, json: { status: status, data: error, msg: msg }
      end
    end
  end
end
