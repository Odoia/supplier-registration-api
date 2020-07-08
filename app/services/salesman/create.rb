module Services
  module Salesman
    class Create

      def initialize(params:)
        @name = params[:name]
        @status = params[:status]
      end

      def call
        create_salesman
      end

      private

      attr_reader :name, :status

      def create_salesman
        result = ::Salesman.new(salesman_params)

        return result unless result.valid?

        result.save
        result
      end

      def salesman_params
        {
          name: name,
          status: status
        }
      end
    end
  end
end

