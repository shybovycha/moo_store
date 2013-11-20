class OrderItem < ActiveRecord::Base
	belongs_to :order

    def self.from_product(product)
        from_products product, 1
    end

    def self.from_products(product, amount)
        OrderItem.new :title => product.title,
                      :price => product.base_price,
                      :amount => (amount or 1)
    end

    def price_s
        "$ %.2f" % read_attribute(:price)
    end
end
