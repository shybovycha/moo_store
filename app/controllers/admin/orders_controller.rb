class Admin::OrdersController < ApplicationController
    include Administrative

    def index
        @orders = Order.page(@page).per(@per_page)
    end

    def edit
        @order = Order.find(params[:id])
    end
end