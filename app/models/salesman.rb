class Salesman < ApplicationRecord
has_many :phone, class_name: '::Phone'

  validates :name, presence: true
end
