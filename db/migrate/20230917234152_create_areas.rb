class CreateAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.boolean :is_protected
      t.integer :can_access_by, array: true, default: []

      t.timestamps
    end
  end
end
