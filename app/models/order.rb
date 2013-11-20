class Order < ActiveRecord::Base
    belongs_to :user
    has_many :order_items, :dependent => :destroy

    validates :payment_method,
              :inclusion => {
                  :in => proc { |object| object.payment_methods },
                  :message => 'was not selected'
              }

    validates :address,
              :presence => {
                  :message => 'to deliver was not set'
              }

    # Order Status could be one of the following:
    # :new, :processing, :completed, :canceled

    def payment_methods
        [ 'Cash', 'Master Card', 'Visa' ]
    end

    def total_price
        prices = order_items.map { |item| item.price.present? ? item.price.to_f : 0.0 }
        prices = prices.present? ? prices : [ 0.0 ]
        prices.inject :+
    end

    def total_price_s
        "$ %.2f" % total_price
    end
end
