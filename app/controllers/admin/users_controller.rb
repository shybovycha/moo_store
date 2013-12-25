class Admin::UsersController < ApplicationController
    include Administrative

    before_action :set_user, :only => [:show, :edit, :update, :destroy]

    def index
        @users = User.page(@page).per(@per_page)
    end

    def new
        @user = User.new
    end

    def edit
    end

    def destroy
        @user.destroy

        redirect_to admin_users_path
    end

    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to admin_users_path, :notice => 'User was successfully created.'
        else
            render :action => 'new'
        end
    end

    def update
        attributes = user_params

        if attributes[:password].blank?
            attributes.delete :password
            attributes.delete :password_confirmation
        end

        @user.update(attributes)

        redirect_to admin_users_path
    end

    protected

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end