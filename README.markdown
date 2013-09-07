# MooShop

## Brief overview

This is a very simple shop sample, inspired by Magento architecture, Rails-based and Moo-powered.
There are some architecture notes, attached below.

## Models

	* User
	* Product
	* ShoppingCart
	* Category
	* Order
	* OrderItem
	* Image
	* ContactMessage
	* Permission
	* Role

### User model

	email, password
	first name, last name, gender, birthday, address, phone
	
	has_many :orders
	has_one :shopping_cart
	has_many_and_belongs_to :role

### Permission model

	action, model

	has_many_and_belongs_to :role

### Role model

	title

	has_many_and_belongs_to :permissions
	has_many_and_belongs_to :user
	
### Product model

	title, description, base_price

	has_many :images
	belongs_to :shopping_cart
	has_many_and_belongs_to :category

### ShoppingCart model
	
	belongs_to :user
	has_many :products

### Category model

	title

	has_many_and_belongs_to :products

### Order model

	address, payment_method, status

	belongs_to :user
	has_many :order_items

### OrderItem model

	title, price

	belongs_to :order

### Image model

	has_attachment :picture

	belongs_to :product

### ContactMessage model

	author_name, author_email, message, status

## Controllers

	* pages
	* users
	* products [Resource]
	* categories [Resource]
	* orders [Resource]
	* backoffice