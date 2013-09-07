class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :picture

      t.integer :product_id

      t.timestamps
    end
  end
end
