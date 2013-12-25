module Administrative
    extend ActiveSupport::Concern

    included do
        layout 'admin'

        before_action do
            @page = params[:page] || 1
            @per_page = params[:per_page] || 10
        end

        # before_action :fetch_all_models, :only => [ :index ]

        # def fetch_all_models
        #     klass_name = self.class.to_s.match(/\b(\w+)Controller$/)[1].classify
        #     klass = Object.const_get klass_name

        #     klass.all
        # end
    end
end