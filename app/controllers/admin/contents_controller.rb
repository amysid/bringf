require 'will_paginate/array'
class Admin::ContentsController < Admin::BaseController
layout "admin"
 
   def index
   @contents = Content.all
   end
   

  

  def edit
    @content = Content.find_by(id: params[:id])
  end
  
  def update
    @contents = Content.find_by(id: params[:id])
    if @contents.update_attributes(content_params)
      redirect_to admin_contents_path, notice: "Content updated successfully."
    else
      render 'edit' , notice: "Something went wrong."
    end
  end




private

def content_params
 params.require(:content).permit(:title, :body, :slug, :meta_keyboard, :meta_description, :published)
end






end
