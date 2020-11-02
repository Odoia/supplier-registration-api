module Presenters
  class Salesman
    attr_reader :id, :name, :status, :phones

    def initialize(attrs)
      @id     = attrs[:id]
      @name   = attrs[:name]
      @status = attrs[:status]
      @phones = phone_presenter(attrs.phones)
    end

    private

    def phone_presenter(phones)
      phones.map { |phone| ::Presenters::Phone.new(phone) }
    end
  end
end
