class Admin::OrdersController < ApplicationController
    include Administrative

    def index
        @orders = Order.all
    end

    def show
    end

    def create
    end

    def new
    end

    def delete
    end

    def edit
    end

    def update
    end
end