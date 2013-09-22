class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :set_shopping_cart

    protected

    def set_shopping_cart
        if user_signed_in?
            stored_cart = current_user
        else
            stored_cart = session
        end

        @shopping_cart = ShoppingCart.new stored_cart
    end
end
