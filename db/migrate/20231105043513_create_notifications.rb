class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.integer :user_with_pendings_actions, null: false
      t.boolean :is_pending, default: true

      t.timestamps
    end
  end
end
