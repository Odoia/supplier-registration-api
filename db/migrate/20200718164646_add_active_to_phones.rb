class AddActiveToPhones < ActiveRecord::Migration[6.0]
  def change
    add_column :phones, :active, :boolean
  end
end
