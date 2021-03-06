class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @micropost = @user.micropost

    institute = @micropost.institute
    case institute
      when  "0"
        @micropost.institute = "新疆理化所"
      when  "1"
        @micropost.institute = "计算技术所"
      when  "2"
        @micropost.institute = "软件所"
      when  "3"
        @micropost.institute = "网络中心"
    end
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      log_in @user
      #@users_five = @user.micropost.where(institute: @user.micropost.institute)
      redirect_to new_micropost_path
    else
      render 'new'
    end
  end
  
  def list
    #@user = User.all
   # @users_five = @current_user
   @users_five = Array.new
    if logged_in?
        users_five1 = User.all
        users_five1.each do |user|
          if user.micropost.gender != current_user.micropost.gender
             @users_five.push(user)
          end
        end
       #@users_five = User.all
       #@users_five = User.where()
       #@users_five = @user.micropost.where(institute: @user.micropost.institute)
    else
        redirect_to login_path
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

  
end
