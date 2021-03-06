class OrdersController < ApplicationController
  before_action :set_order, :only => [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    unless user_signed_in?
      redirect_to new_registration_path
    end

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.new(order_params)

    @shopping_cart.counted_products.each do |product, amount|
        order_item = OrderItem.from_products product, amount
        order_item.save

        @order.items << order_item
    end

    @order.status = :new

    respond_to do |format|
      if @order.save
        @shopping_cart.clear!

        format.html { redirect_to @order, :notice => 'Order was successfully created.' }
        format.json { render :action => 'show', :status => :created, :location => @order }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, :notice => 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      permit = [ :address, :payment_method ]

      permit << :status if action_name == 'update'

      params.require(:order).permit(*permit)
    end
end
