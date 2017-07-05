class ShareProfile < ApplicationMailer

	def send_public_profile_url(email_id,url,user)
		@url = url 
		@to= email_id
		@user=user

    	mail(to: @to, subject: @user.name+" has shared his profile with you")
  	end
  	def send_public_app_url(email_id,url,user)
		@url = url 
		@to= email_id
		@user=user

    	mail(to: @to, subject: @user.name+" has shared an app with you")
  	end
end
