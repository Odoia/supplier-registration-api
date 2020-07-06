module Api
  module V1
    class SalesmanController < ApplicationController

      def create
        if params[:name].nil? || params[:status].nil?
          render nothing: true, status: 400, json: { status: 400, data: 'Bad Request' }
        else
          salesman = ::Salesman.new({
            name: params[:name],
            status: params[:status]
          })
          salesman.save

          render status: 201, json: { data: salesman, status: 201 }
        end
      end

      def update
        salesman = ::Salesman.find(params[:id])
        if salesman.valid?
          salesman.name = params[:name]
          salesman.status = params[:status]
          salesman.save
          render status: 200, json: {data: salesman, status:200}
        else
          render status: 404, json: {status: 404, data:'Not Found'}
        end
      end

    end
  end
end
