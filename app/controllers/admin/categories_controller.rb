class Admin::CategoriesController < ApplicationController
    include Administrative

    def index
        @categories = Category.page(@page).per(@per_page)
    end

    def new
        @category = Category.new
    end

    def edit
        @category = Category.find(params[:id])
    end

    def show
    end
end