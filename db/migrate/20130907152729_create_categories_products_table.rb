class CreateCategoriesProductsTable < ActiveRecord::Migration
  def change
    create_table :categories_products, :id => false do |t|
    	t.integer :product_id
    	t.integer :category_id
    end
  end
end
