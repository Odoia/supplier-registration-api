module Services
  module Salesman
    class Update
      def initialize(id:, update_params:)
        @name = update_params[:name]
        @status = update_params[:status]
        @id = id
      end

      def call
        update_salesman
      end

      private

      attr_reader :name, :status, :id

      def update_salesman
        salesman = ::Salesman.find_by(id: id)
        if salesman.blank?
          nil
        else
          salesman.update(salesman_params)
          salesman
        end
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