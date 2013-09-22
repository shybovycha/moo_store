class ShoppingCart
    class CartStorage
        class SessionStorage
            def initialize(session)
                @session = session
            end

            def save(data)
                @session[:shopping_cart] = data
            end

            def load
                @session[:shopping_cart] || nil
            end
        end

        class DBStorage
            def initialize(model)
                @model = model
            end

            def save(data)
                @model.update_attribute :shopping_cart, data
            end

            def load
                @model.shopping_cart
            end
        end

        def initialize(storage)
            if storage.is_a? ActiveRecord::Base
                @storage = DBStorage.new(storage)
            else
                @storage = SessionStorage.new(storage)
            end
        end

        def save(data)
            @storage.save(data)
        end

        def load
            @storage.load
        end
    end

    def initialize(storage)
        @storage = CartStorage.new(storage)
        parse(@storage.load)
    end

    def products
        items.map { |product_id, _| Product.find(product_id) }
    end

    def counted_products
        Hash[items.map { |product_id, count| [ Product.find(product_id), count ] }]
    end

    def items
        @items = {} unless @items.present?

        @items
    end

    def size
        # sum of product counts in the cart is less than one product
        ((items.map { |_, count| count }).inject :+) || 0
    end

    def empty?
        size < 1
    end

    def add_product(product)
        key = product.id.to_s

        if items.has_key? key
            items[key] += 1
        else
            items[key] = 1
        end

        save
    end

    def remove_product(product)
        items.delete items[product.id]

        save
    end

    def update_product_count(product, count)
        if count > 0
            items[product.id] = count
        else
            remove_product(product)
        end

        save
    end

    def dump
        items.to_json
    end

    def parse(string)
        if string.blank?
            @items = {}
        else
            @items = JSON.parse(string)
        end
    end

    def save
        @storage.save dump
    end
end
