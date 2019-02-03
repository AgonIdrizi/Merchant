class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.string :first_name
      t.string :last_name
      t.string :last4
      t.decimal :amount, precision: 12, scale: 3
      t.boolean :success
      t.string :authorization_code

      t.timestamps
    end
  end
end