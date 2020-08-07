class CreatePhone < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.string :number
      t.boolean :whatsapp
      t.references :salesman

      t.timestamps
    end
  end
end
