class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :commercial_activity, null: false
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
