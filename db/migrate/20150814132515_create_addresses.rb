class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :city
      t.string :state
      t.string :zip
      t.string :price

      t.timestamps null: false
    end
  end
end
