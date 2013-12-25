class Order < ActiveRecord::Base
  STATUSES = [ :new, :processing, :completed, :cancelled ]
  PAYMENT_METHODS = [ 'Cash', 'Master Card', 'Visa' ]

  belongs_to :user
  has_many :items, :dependent => :destroy, :foreign_key => :order_id, :class_name => 'OrderItem'

  validates :payment_method,
            :inclusion => {
                :in => PAYMENT_METHODS,
                :message => 'was not selected'
            }

  validates :address,
            :presence => {
                :message => 'to deliver was not set'
            }

  def status
    (read_attribute :status).to_sym
  end

  def status=(value)
    value = value.to_sym
    errors[:status] << "Unrecognized status `#{ value }`" unless STATUSES.include? value
    write_attribute :status, value
  end

  def total_price
      prices = items.map { |item| item.price.present? ? item.price.to_f : 0.0 }
      prices = prices.present? ? prices : [ 0.0 ]
      prices.inject :+
  end

  def total_price_s
      "$ %.2f" % total_price
  end
end
