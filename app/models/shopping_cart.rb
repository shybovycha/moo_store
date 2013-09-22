class ShoppingCart
    class CartStorage
        class BaseStorage
            def dump(data)
                data.to_json
            end

            def parse(data)
                JSON.parse(data)
            rescue
                if data.is_a? Hash
                    data
                else
                    {}
                end
            end
        end

        class SessionStorage < BaseStorage
            def initialize(session)
                @session = session
            end

            def save(data)
                @session[:shopping_cart] = dump(data)
            end

            def load
                parse(@session[:shopping_cart] || nil)
            end
        end

        class DBStorage < BaseStorage
            def initialize(model)
                @model = model
            end

            def save(data)
                @model.update_attribute :shopping_cart, dump(data)
            end

            def load
                parse(@model.shopping_cart)
            end
        end

        class MergedStore < BaseStorage
            def initialize(model, session)
                @session = session
                @model = model
            end

            def save(data)
                @model.update_attribute :shopping_cart, dump(data)
            end

            def load
                session_data = parse(@session[:shopping_cart])
                model_data = parse(@model.shopping_cart)

                merged_data = session_data.merge(model_data) { |_, old_amount, new_amount| old_amount + new_amount }

                @session.delete :shopping_cart
                @model.update_attribute :shopping_cart, dump(merged_data)

                merged_data
            end
        end

        def initialize(storage, secondary_storage)
            if secondary_storage.present?
                @storage = MergedStore.new(storage, secondary_storage)
            elsif storage.is_a? ActiveRecord::Base
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

    def initialize(storage, secondary_storage = nil)
        @storage = CartStorage.new(storage, secondary_storage)
        load
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

    def load
        @items = @storage.load
    end

    def save
        @storage.save items
    end
end
