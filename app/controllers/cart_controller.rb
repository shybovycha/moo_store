class CartController < ApplicationController
    def add_to_cart
        product = Product.find(params[:product_id])

        @shopping_cart.add_product product

        if request.referer
            redirect_to request.referer
        else
            redirect_to url_for(:controller => :cart, :action => :show)
        end
    end

    def remove_from_cart
        product = Product.find params[:product_id]

        @shopping_cart.remove_product product

        if request.referer
            redirect_to request.referer
        else
            redirect_to url_for(:controller => :cart, :action => :show)
        end
    end

    def show
        if user_signed_in?
            @cart = current_user.cart
            @products = @cart.counted_products
        else
            @cart = ShoppingCart.new

            if session[:cart].present?
                product_ids = session[:cart]
                @products = product_ids.map { |id| Product.find(id) }
            else
                @products = []
            end

            @cart.products = @products
        end
    end

    def checkout
    end
end