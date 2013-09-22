class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :set_shopping_cart, :cancan_strong_attributes

    protected

    def set_shopping_cart
        if user_signed_in?
            if session.has_key? :shopping_cart
                @shopping_cart = ShoppingCart.new current_user, session
            else
                @shopping_cart = ShoppingCart.new current_user
            end
        else
            @shopping_cart = ShoppingCart.new session
        end
    end

    def cancan_strong_attributes
        resource = controller_name.singularize.to_sym
        method = "#{resource}_params"

        params[resource] &&= send(method) if respond_to?(method, true)
    end
end
