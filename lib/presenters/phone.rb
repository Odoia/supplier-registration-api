module Presenters
  class Phone
    attr_reader :id, :number, :whatsapp

    def initialize(attrs)
      @id       = attrs[:id]
      @number   = attrs[:number]
      @whatsapp = attrs[:whatsapp]
    end
  end
end
