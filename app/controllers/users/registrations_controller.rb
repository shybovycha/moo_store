class Users::RegistrationsController < Devise::RegistrationsController
    before_filter :check_permissions, :only => [:new, :create, :cancel]
    skip_before_filter :require_no_authentication

    def check_permissions
        authorize! :create, resource
    end

    def edit
        @orders = current_user.orders #.where { status.in [ 'complete', 'canceled' ] }
    end
end