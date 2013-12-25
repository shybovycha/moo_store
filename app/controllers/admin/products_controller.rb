class Admin::ProductsController < ApplicationController
    include Administrative

    before_action :set_product, :only => [ :show, :edit, :update, :destroy ]

    def index
        @products = Product.page(@page).per(@per_page)
    end

    def new
        @product = Product.new
    end

    def edit
    end

    def show
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            if @category.present?
                @product.category = @category
                @product.save
            end

            redirect_to admin_products_path, :notice => 'Product was successfully created.'
        else
            render :action => 'new'
        end
    end

    def update
        @product.update(product_params)

        if @category.present?
            @category.products << @product
            @category.save
        end

        redirect_to admin_products_path
    end

    def destroy
        @product.destroy

        redirect_to admin_products_path
    end

    protected

    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        attributes = params.require(:product).permit(:title, :description, :base_price, :category)

        return if attributes[:category].blank?

        @category = Category.find(attributes[:category])

        attributes.delete :category

        attributes
    end
end