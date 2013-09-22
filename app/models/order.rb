class Order < ActiveRecord::Base
    belongs_to :user
    has_many :order_items

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
end
