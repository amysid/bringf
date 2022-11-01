class Admin::BlogsController < Admin::BaseController
layout "admin"
  
  def index
    @blogs = Blog.all 
  end

 
  def edit
      @blog = Blog.find_by(id: params[:id])
  end

 

  # for update Condition
  def update
  	@blog = Blog.find_by(id: params[:id])
  	if @blog.update(update_params_blog)
      flash[:notice] = "Blog updated successfully."
  	  redirect_to admin_contents_path
    else
      flash[:error] = "Blog unable to update."
      redirect_to edit_admin_Privacy_path
    end
  end

 

  private
  

  def update_params_blog
     params.require(:blog).permit(:title,:body)
  end
end
