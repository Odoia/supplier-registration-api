module Services
  module Supplier
    class Create

      def initialize(params:)
        @cnpj = params['cnpj']
        @fantasy_name = params['fantasy_name']
        @social_reason = params['social_reason']
      end

      def call
        create_supplier
      end

      private

      attr_reader :cnpj, :fantasy_name, :social_reason

      def create_supplier
        result = ::Supplier.new(supplier_params)
        result.save
        result
      end

      def supplier_params
        {
          cnpj: cnpj,
          fantasy_name: fantasy_name,
          social_reason: social_reason
        }
      end
    end
  end
end
