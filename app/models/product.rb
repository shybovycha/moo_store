class Product < ActiveRecord::Base
    has_many :images
    belongs_to :shopping_cart
    has_and_belongs_to_many :category

    default_scope order('created_at')

    paginates_per 8

    def price
        "$ %.2f" % base_price
    end
end
