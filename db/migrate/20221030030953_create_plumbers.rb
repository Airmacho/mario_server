class CreatePlumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :plumbers do |t|
      t.string :name
      t.string :address
      t.string :vehicles

      t.timestamps
    end
  end
end
