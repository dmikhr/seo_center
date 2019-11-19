class Admin::UsersController < ApplicationController

  authorize_resource

  def index
     @users = User.where(admin: false)
   end
end
