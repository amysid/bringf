class Admin::DisclaimerPolicysController < Admin::BaseController
layout "admin"
  
  def index
    @policies = DisclaimerPolicy.all 
  end

 
  def edit
      @policy = DisclaimerPolicy.find_by(id: params[:id])
  end

 

  # for update policy
  def update
  	@policy = DisclaimerPolicy.find_by(id: params[:id])
  	if @policy.update(update_params_policy)
      flash[:notice] = "DisclaimerPolicy updated successfully."
  	  redirect_to admin_contents_path
    else
      flash[:error] = "DisclaimerPolicy unable to update."
      redirect_to edit_admin_Privacy_path
    end
  end

 

  private
  

  def update_params_policy
     params.require(:disclaimer_policy).permit(:title,:body)
  end
end
