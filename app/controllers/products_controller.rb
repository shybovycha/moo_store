class ProductsController < ApplicationController
  before_action :set_product, :only => [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
    @products = Product.page(params[:page] || 1)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, :notice => 'Product was successfully created.' }
        format.json { render :action => 'show', :status => :created, :location => @product }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, :notice => 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def export
      xml = render_to_string 'export.xml.erb'
      filename = "products_#{ DateTime.now.strftime '%Y_%m_%d' }.xml"

      send_data xml, :type => 'application/xml', :disposition => 'attachment', :filename => filename
  end

  def import
      params.require(:products)

      xml = File.read params[:products].tempfile
      doc = Nokogiri.XML xml

      @categories = doc.css('export_data categories category')

      @categories.each do |elt|
          title = elt.css('title').first.content

          c = Category.create :title => title

          c.save
      end

      @products = doc.css('export_data products product')

      count = 0

      @products.each do |elt|
          title = elt.css('title').first.content
          base_price = elt.css('base_price').first.content
          description = elt.css('description').first.content

          prod = Product.create :title => title,
                             :base_price => base_price,
                             :description => description

          count += 1 if prod.errors.none?

          prod.save

          categories = elt.css('category')

          categories.each do |cat_elt|
              category_title = cat_elt.content

              cat = Category.find_by_title category_title

              next if cat.blank?

              cat.products << prod

              cat.save
          end
      end

      redirect_to :back, :notice => "Imported #{ count } products"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :base_price)
    end
end
