class MessagesController < ApplicationController
	def new
		@message = Message.new
	end

	def create
		@message = Message.new
		@message.subject = params[:message][:subject]
		@message.content = params[:message][:content]
		@message.user_id = session[:user_id]
		@message.politician_id = request.referer[34..-1].to_i
		@message.save
		flash[:alert] = "Post successfully created"
		sleep 2
		redirect_to politician_path(Politician.find_by(id: @message.politician_id))
		flash[:alert] = "Post successfully created"
	end
end
