module Administrative
    extend ActiveSupport::Concern

    included do
        layout 'admin'
    end
end