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
    end
  end
end
