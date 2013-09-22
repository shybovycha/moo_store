class AddShoppingCartToUsers < ActiveRecord::Migration
  def change
      add_column :users, :shopping_cart, :string, :default => ''
  end
end
