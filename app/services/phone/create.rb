module Services
  module Phone
    class Create

      def initialize(params:, salesman_id:)
        @salesman_id = salesman_id
        @phones = params
      end

      def call
        make_phone
      end

      private

      attr_reader :phones, :salesman_id

      def make_phone
        return nil unless phones

        phones.map do |phone|
          result = ::Phone.new(
            salesman_id: salesman_id,
            number: phone[:number],
            whatsapp: phone[:whatsapp],
            active: true
          )
          result.save
          result
        end
      end
    end
  end
end
