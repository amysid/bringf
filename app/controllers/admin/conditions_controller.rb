class Admin::ConditionsController < Admin::BaseController
layout "admin"
  
  def index
    @conditions = Condition.all 
  end

 
  def edit
      @condition = Condition.find_by(id: params[:id])
  end

 

  # for update Condition
  def update
  	@condition = Condition.find_by(id: params[:id])
  	if @condition.update(update_params_condition)
      flash[:notice] = "Condition updated successfully."
  	  redirect_to admin_contents_path
    else
      flash[:error] = "Condition unable to update."
      redirect_to edit_admin_Privacy_path
    end
  end

 

  private
  

  def update_params_condition
     params.require(:condition).permit(:title,:body)
  end
end
