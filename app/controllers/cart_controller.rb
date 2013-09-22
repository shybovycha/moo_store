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
    end

    def checkout
        if user_signed_in?
            redirect_to new_order_path
        end
    end
end