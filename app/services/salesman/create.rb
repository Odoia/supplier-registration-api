module Services
  module Salesman
    class Create

      def initialize(params:)
        @name   = params[:name]
        @status = params[:status]
        @phone  = params[:phones]
      end

      def call
        make_salesman
      end

      private

      attr_reader :name, :status, :phone

      def make_salesman
        ActiveRecord::Base.transaction do
          result_salesman = create_salesman

          return result_salesman unless result_salesman.errors.blank?

          phone_service(result_salesman.id)

          ::Presenters::Salesman.new(result_salesman)
        end

      end

      def create_salesman
        result = ::Salesman.new(salesman_params)
        result.save
        result
      end

      def salesman_params
        {
          name: name,
          status: status
        }
      end

      def phone_service(salesman_id)
        ::Services::Phone::Create.new(params: phone, salesman_id: salesman_id).call
      end
    end
  end
end

