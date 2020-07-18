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
        phone = ::Phone.find_by(id: phone_id)

        if phone.blank?
          nil

        elsif verify_amount_whatsapp == 1 && phone.whatsapp

          result = { errors: "Salesman must have at least one number whatsapp" }
          result

        else
          phone.active = false
          phone.save
          phone
        end
      end


      def verify_amount_whatsapp

        whatsapps = ::Phone.where(whatsapp: true).where(salesman_id: salesman_id).count
        whatsapps
      end

    end
  end
end
