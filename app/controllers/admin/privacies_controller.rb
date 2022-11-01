class Admin::PrivaciesController < Admin::BaseController
layout "admin"
  
  def index
    @privacies = Privacy.all 
  end

  # for edit Privacy
  def edit
      @privacy = Privacy.find_by(id: params[:id])
  end

  # for show Privacy
  # def show
  	
  # 	@Privacy = Privacy.find(params[:id])
  # end

  # for update Privacy
  def update
  	@privacy = Privacy.find_by(id: params[:id])
  	if @privacy.update(update_params_Privacy)
      flash[:notice] = "Privacy updated successfully."
  	  redirect_to admin_contents_path
    else
      flash[:error] = "Privacy unable to update."
      redirect_to edit_admin_Privacy_path
    end
  end

  # for delete Privacy
  # def destroy
  #   @Privacy = Privacy.find(params[:id])
  #   if @Privacy.destroy
  #     flash[:notice] = "Privacy delete successful."
  #     redirect_to admin_privacies_path
  #   else
  #     flash[:error] = "Privacy unable to delete."
  #     redirect_to admin_privacies_path
  #   end
  # end

  private
  

  def update_params_Privacy
     params.require(:privacy).permit(:title,:body)
  end
end
