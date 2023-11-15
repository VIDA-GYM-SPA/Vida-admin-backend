class AddPagoMovilToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :phone, :string
    add_column :payments, :dni, :string
  end
end
