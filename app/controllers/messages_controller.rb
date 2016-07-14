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
		binding.pry
	end
end
