class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :email
      t.string :dni
      t.string :password_digest
      t.string :gender
      t.string :uuid
      t.string :rfid
      t.string :status
      t.text :fingerprint
      t.integer :permissions, array: true, default: []
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
 