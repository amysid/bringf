require 'will_paginate/array'
class Admin::UsersController < Admin::BaseController

layout "admin"
before_action :admin_authentication_user
skip_before_action :verify_authenticity_token
# before_action :admin_authenticate_country, only: [:edit,:update, :create_state]
 # before_action :find_user, except: [:new, :create, :index]


    def index
          params[:user] = "active"
           if params[:search].present?
              full_name = params[:search].split(" ")
              @search=true
              #@users = User.where("first_name ILIKE ? or email ILIKE ? or phone_no ILIKE ? "   , "%#{params[:search]}%" , "%#{params[:search]}%" , "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 5)
              @users = User.where("first_name ILIKE ? or last_name ILIKE ? or (first_name ILIKE ? and last_name ILIKE ? )"   ,"%#{params[:search]}%","%#{params[:search]}%", "%#{full_name[0]}","#{full_name[1]}%" ).paginate(:page => params[:page], :per_page => 5)

              # flash[:notice]  = "Nothing to show." if @users.count == 0
           else
             @users = User.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
          end
          respond_to do |format| 
          format.html
          format.js
        end
      end

      def new 
        @user = User.new
        @states = []
      end



      def create
           @user = User.new(user_params)
          if @user.save
           redirect_to admin_users_path, notice: "User  created successfully"
         else 
          flash[:error] = "Please fill the mandatory data."
          redirect_to new_admin_user_path
      end
    end




      def destroy
         @user = User.find(params[:id])
         @user.destroy
         redirect_to admin_users_path, notice: "User  deleted successfully"
      end


      def edit
       @user = User.find(params[:id])
       @states = @user.state.present? ? [@user.state] : []
      end

      def update
        @user = User.find(params[:id])

         if @user.update_attributes(user_params)
            flash[:notice] = "User updated successfully."
            redirect_to admin_users_path
         else
            flash[:error] = "Unable to save the user."
            redirect_to new_admin_user_path
        end
      end

 

      def show
      end

      #for block and unblock merchant
    	def unblock
    	  @user = User.find(params[:id])
    	  if @user.is_block == true
    		  @user.update(is_block: false)
    	  else
    	  	@user.update(is_block: true)
    	  end
        flash[:notice] = "User #{@user.is_block? ? 'blocked' :  'unblocked' } successfully "
        redirect_to admin_users_path
      end



      def country_change
        @country_id = Country.where(country_name: params[:country_name]).first.id
        @states = State.where(country_id: @country_id).pluck(:state_name)
        return render json: {state: @states}
      end



      private

        # def admin_authenticate_country
        #   if params[:state].present?
        #     @country = Country.find( params[:state][:country_id])
        #   else
        #     @country = Country.find(params[:id])
        #   end
        # end

        def user_params
          params.require(:user).permit(:first_name,:last_name,:dob,:email,:password,:phone_no,:country_code,:address,:country,:state,:city,:zip,:image)
        end




       
      end
