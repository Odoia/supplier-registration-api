class CreateSalesman < ActiveRecord::Migration[6.0]
  def change
    create_table :salesmen do |t|
      t.string :name, :status

      t.timestamps
    end
  end
end
