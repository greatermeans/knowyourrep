class PoliticiansController < ApplicationController

	def show
		@politician = Politician.find(params[:id])
	end

	def index
		@politicians = Politician.all
	end

end
