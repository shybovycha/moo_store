class Admin::CategoriesController < ApplicationController
    include Administrative

    def index
        @categories = Category.all
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