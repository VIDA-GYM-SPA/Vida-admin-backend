class CreateExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :exchanges do |t|
      t.float :dolar

      t.timestamps
    end
  end
end
