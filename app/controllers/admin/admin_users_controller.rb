class Admin::AdminUsersController < Admin::BaseController
layout "admin"

before_action :find_admin_user, except: [:index, :new, :create]
before_action :admin_authentication_user




  def edit
    
  end



  def update
    if @admin_user.update_attributes(admin_user_params)
      redirect_to admin_homes_path
      flash[:notice] = "Successfully updated"
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to :back
    end
  end
  
  def change_password
  end

    def update_password
  p "*******************#{admin_user.inspect}"
  unless (params[:admin_user][:new_password] == params[:admin_user][:confirm_password])
  flash[:error] = "password and confirm password does't match."
  return redirect_to change_password_admin_admin_user_path

  end
    if admin_user.authenticate(params[:admin_user][:old_password])
      admin_user.update_attributes(password: params[:admin_user][:new_password])
      flash[:notice] = "password has sucessfully updated."
      redirect_to admin_homes_url
    else
      flash[:error] = "password unable to update"
      redirect_to admin_homes_url
    end
  end

  

   private
  def find_admin_user
    @admin_user = AdminUser.find_by(id: params[:id])
    redirect_to admin_home_index_path unless @admin_user
  end
   def admin_user_params
    params.require(:admin_user).permit(:email, :name, :mobile, :dob, :address, :city, :image)
  end




end
