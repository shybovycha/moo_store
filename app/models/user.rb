class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

    has_many :orders
    has_and_belongs_to_many :roles

    has_settings do |s|
        # s.key :dashboard, :defaults => { :theme => 'blue', :view => 'monthly', :filter => false }
        s.key :store, :defaults => { :role => 'blue', :view => 'monthly', :filter => false }
    end

    def admin?
        (roles.select { |r| r.permissions.where(:action => 'manage', :model => 'Role').present? }).present?
    end
end
