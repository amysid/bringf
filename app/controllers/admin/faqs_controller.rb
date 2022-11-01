class Admin::FaqsController <  Admin::BaseController
  layout "admin"
 







 
  def index
    @faqs = Faq.all.order('created_at DESC').paginate(:page => params[:page_1], :per_page => 5) 
  end

  #for initializing faq
  def new
    @faq = Faq.new
  end

  #for create faq
  def create
    @faq = Faq.new(update_params)
    if @faq.save!
      flash[:notice] = "faq created successfully."
    	redirect_to admin_faqs_path
    else
      flash[:error] = "faq unable to create ."
    	redirect_to new_admin_faq_path
    end
  end

  # for edit faq
  def edit
    @faq = Faq.find(params[:id])
  end

  # for show faq
  def show
  	@faq = Faq.find(params[:id])
  end

  # for update faq
  def update
  	@faq = Faq.find(params[:id])
  	if @faq.update(update_params_faq)
      flash[:notice] = "faq updated successfully."
  	  redirect_to admin_faqs_path
    else
      flash[:error] = "faq unable to update."
      redirect_to edit_admin_faq_path
    end
  end

  # for delete faq
  def destroy
    @faq = Faq.find(params[:id])
    if @faq.destroy
      flash[:notice] = "faq delete successful."
      redirect_to admin_faqs_path
    else
      flash[:error] = "faq unable to delete."
      redirect_to admin_faqs_path
    end
  end

  private
  def update_params
    params.permit(:question, :answer)
  end

  def update_params_faq
     params.require(:faq).permit(:question,:answer)
  end
end
