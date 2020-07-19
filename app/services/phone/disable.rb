module Services
  module Phone
    class Disable

      def initialize(salesman_id:, phone_id:)
        @phone_id = phone_id
        @salesman_id = salesman_id
      end

      def call
        disable_phone
      end

      private

      attr_reader :phone_id, :salesman_id

      def disable_phone
        return nil if phone.blank?

        return validate_disable unless validate_disable.blank?

        phone.active = false
        phone.save
        phone
      end

      def validate_disable
        if whatsapp_counter_by_salesman == 1 && phone.whatsapp
          { errors: 'Salesman must have at least one number whatsapp' }
        end
      end

      def phone
        ::Phone.find_by(id: phone_id)
      end

      def whatsapp_counter_by_salesman
        ::Salesman.find_by(id: salesman_id).whatsapp_counter
      end
    end
  end
end
