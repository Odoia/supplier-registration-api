module Services
  module Supplier
    class Update

      def initialize(id:, params:)
        @cnpj = params[:cnpj]
        @fantasy_name = params[:fantasy_name]
        @social_reason = params[:social_reason]
        @id = id
      end

      def call
        update_supplier
      end

      private

      attr_reader :cnpj, :fantasy_name, :social_reason, :id

      def update_supplier
        supplier = ::Supplier.find_by(id: id)
        if supplier.blank?
          nil
        else
          supplier.update(
            supplier_params
          )
          supplier.save
          supplier
        end
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