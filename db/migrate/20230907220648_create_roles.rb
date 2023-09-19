class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :uuid
      t.integer :base_permissions, array: true, default: []

      t.timestamps
    end
  end
end
