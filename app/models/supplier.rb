class Supplier < ApplicationRecord

  validates :cnpj, :social_reason, :fantasy_name, presence: true
end
