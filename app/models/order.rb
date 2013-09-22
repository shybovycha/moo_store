class Order < ActiveRecord::Base
    belongs_to :user
    has_many :order_items

    # Order Status could be one of the following:
    # :new, :processing, :completed, :canceled

    def self.payment_methods
        [ 'Cash', 'Master Card', 'Visa' ]
    end
end
