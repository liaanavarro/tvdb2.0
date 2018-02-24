class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.valid?
      salt = BCrypt::Engine.generate_salt
      @user.salt = salt
      @user.password = BCrypt::Engine.hash_secret(:password, salt)
      @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
      redirect_to '/'
    # else
    #   flash[:notice] = "Form is invalid"
    #   flash[:color]= "invalid"
    else
      render "new"
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :name, :password)
    end

end