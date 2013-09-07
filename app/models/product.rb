class Product < ActiveRecord::Base
	has_many :images
	belongs_to :shopping_cart
	has_and_belongs_to_many :category
end
