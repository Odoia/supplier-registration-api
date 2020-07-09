module Services
  module Salesman
    class Update
      def initialize(id, name, status)
        @name = name
        @status = status
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
          404
        else
          salesman.name = salesman_params[:name]
          salesman.status = salesman_params[:status]
          salesman.save
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