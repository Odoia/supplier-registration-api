class CreateSupplier < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.string :cnpj, :social_reason, :fantasy_name

      t.timestamps
    end
  end
end
