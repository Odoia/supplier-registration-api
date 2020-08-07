class Phone < ApplicationRecord
  belongs_to :salesman, class_name: '::Salesman'

  validates :number, presence: true
  # todo: validar whatsapp quando passar false
  # validates :whatsapp, presence: true
end
