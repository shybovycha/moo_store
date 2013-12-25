class Admin::ProductsController < ApplicationController
    include Administrative

    def index
        @products = Product.all
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