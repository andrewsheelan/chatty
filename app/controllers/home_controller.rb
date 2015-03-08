class HomeController < ApplicationController
	require 'pusher'
	layout 'home'

	protect_from_forgery :except => :presence_auth # stop rails CSRF protection for this action

	def index
	end

	def presence
	end

	def presence_auth

		# if using devise or some other login system, this is where you'd check
		# to see if the user is logged in
		# 
		# if current_user
		#   user_id = current_user.id
		#   user_name = current_user.name
		#   user_email = current_user.email
		#

		if params[:channel_name] and params[:socket_id] and !params[:channel_name].empty? and !params[:socket_id].empty?
			
			# Note: just simulating creating a random user

			user_id 			= rand(1000)
			user_name 			= "user-#{user_id}"
			user_email 			= "#{user_name}@andrew.com"
			hostname 			= Rails.application.config.app_properties[:hostname]

			response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
				:user_id => user_id, # => required
				:user_info => { # => optional - for example
					:name => user_name,
					:hostname => hostname,
					:email => user_email
				}
			})

			render :json => response
		else
			render :text => "forbidden", :status => '403'
	    end

	end

	def presence_chat
      @chat = Chat.new(presence_params)
      if @chat.save
		hostname 			= Rails.application.config.app_properties[:hostname]

        Pusher['presence-test_channel'].trigger('my_event', {
          id: @chat.id,
          message: @chat.message,
          hostname: hostname,
          user: @chat.user.name,
          color: @chat.user.color,
          created_at: @chat.user.created_at.strftime("%I:%M%p")
        })
      end
      render nothing: true
  	end

 	 private

	# Never trust parameters from the scary internet, only allow the white list through.
	def presence_params
		params.require(:chat).permit(:user_id, :message)
	end

end
