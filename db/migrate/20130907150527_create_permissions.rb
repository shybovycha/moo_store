class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :action
      t.string :model
      t.integer :instance_id, :required => false
      t.boolean :allowed, :default => false

      t.timestamps
    end
  end
end
