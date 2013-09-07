class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.string :payment_method
      t.string :status
      
      t.integer :user_id

      t.timestamps
    end
  end
end
