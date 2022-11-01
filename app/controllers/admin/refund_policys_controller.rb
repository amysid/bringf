class Admin::RefundPolicysController < Admin::BaseController
layout "admin"
  
  def index
    @policies = RefundPolicy.all 
  end

 
  def edit
      @policy = RefundPolicy.find_by(id: params[:id])
  end

 

  # for update policy
  def update
  	@policy = RefundPolicy.find_by(id: params[:id])
  	if @policy.update(update_params_policy)
      flash[:notice] = "Refund Policy updated successfully."
  	  redirect_to admin_contents_path
    else
      flash[:error] = "Refund Policy unable to update."
      redirect_to edit_admin_Privacy_path
    end
  end

 

  private
  

  def update_params_policy
     params.require(:refund_policy).permit(:title,:body)
  end
end
