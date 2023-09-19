class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :reason
      t.float :amount
      t.string :money
      t.string :method
      t.string :reference
      t.string :bank
      t.string :process_date
      t.date :payed_at
      t.references :user, null: false, foreign_key: true
      t.boolean :is_accepted, default: false
      t.float :discount

      t.timestamps
    end
  end
end
