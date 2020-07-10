module Api
  module V1
    class SalesmanController < ApplicationController

      def create
        if salesman_params.permitted?
          result = salesman_service_create

          if result.errors.blank?
            render status: 201, json: {data: result, status: 201}
          else
            render nothing: true, status: 400, json: {status: 400, data: result.errors[:name]}
          end
        else
          render nothing: true, status: 400, json: {status: 400, data: 'Bad Request'}
        end
      end

      def update
        salesman = salesman_service_update

        if salesman.blank?

          render status: 404, json: {status: 404, data: 'Not Found'}

        else

          render status: 200, json: {data: salesman, status: 200}

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
        params.require(:salesman).permit(:name, :status)
      end
    end
  end
end
