class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :title
      t.float :price

      t.integer :order_id

      t.timestamps
    end
  end
end
