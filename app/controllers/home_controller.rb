class HomeController < ApplicationController
	require 'pusher'
	layout 'home'

	protect_from_forgery :except => :presence_auth # stop rails CSRF protection for this action

	def index
	end

	def presence
	end

	def presence_auth

		if params[:channel_name] and params[:socket_id] and !params[:channel_name].empty? and !params[:socket_id].empty?
			user_id 			= rand(1000)
			user_name 			= "user-#{user_id}"
			user_email 			= "#{user_name}@andrew.com"

			response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
				:user_id => user_id, # => required
				:user_info => { # => optional - for example
					:name => user_name,
					:email => user_email
				}
			})

			render :json => response
		else
			render :text => "forbidden", :status => '403'
	    end

	end

	def presence_chat
      @chat = Chat.new(chat_params)
      if @chat.save
        Pusher['presence-test_channel'].trigger('my_event', {
          id: @chat.id,
          message: @chat.message,
          user: @chat.user.name,
          color: @chat.user.color,
          created_at: @chat.user.created_at.strftime("%I:%M%p")
        })
      end
      render nothing: true
  end

  private

	# Never trust parameters from the scary internet, only allow the white list through.
	def chat_params
		params.require(:chat).permit(:user_id, :message)
	end

end
