class Admin::NewslettersController < Admin::BaseController
layout 'admin'
	
	def index
		@subsciptions = Newsletter.all.paginate(:page => params[:page], :per_page => 10)
	end

	def create
		emails = Newsletter.where(is_subscribed: true).uniq.pluck(:email) if  Newsletter.all.present?
		 emails.each do |mail|
		UserMailer.send_subscription_info(params[:content][:body], mail).deliver_now
	end
		flash[:notice] = "Subscription Mail Sent."
		redirect_to admin_newsletters_path
	end

	def subscription_status_change
		subscription = Newsletter.find_by(id: params[:subs_id])
		if subscription.present?
		  subscription.update(is_subscribed: !subscription.is_subscribed)
		  render :json => subscription.is_subscribed
		else
		  render :json => 400
		end
	end
end
