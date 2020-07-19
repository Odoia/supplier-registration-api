class Salesman < ApplicationRecord
has_many :phone, class_name: '::Phone'

  validates :name, presence: true


  def whatsapp_counter
    result = self.phone.map { |x| x.whatsapp }.tally
    result[true]
  end
end
