class CreateProductsCategoriesTable < ActiveRecord::Migration
  def change
    create_table :products_categories, :id => false do |t|
    	t.integer :product_id
    	t.integer :category_id
    end
  end
end
