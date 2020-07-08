module Api
  module V1
    class SalesmanController < ApplicationController

      def create
        if salesman_params.permitted?
          result = salesman_service

          if result.errors.blank?
            render status: 201, json: { data: result, status: 201 }
          else
            render nothing: true, status: 400, json: { status: 400, data: result.errors[:name] }
          end
        else
          render nothing: true, status: 400, json: { status: 400, data: 'Bad Request' }
        end
      end

      def update
        salesman = ::Salesman.find_by(id: params[:id])

        unless salesman.blank?
          salesman.name = params[:name]
          salesman.status = params[:status]
          salesman.save
          render status: 200, json: {data: salesman, status:200}
        else
          render status: 404, json: {status: 404, data:'Not Found'}
        end
      end

      private

      def salesman_service
        ::Services::Salesman::Create.new(params: salesman_params).call
      end

      def salesman_params
        params.require(:salesman).permit(:name, :status)
      end
    end
  end
end
