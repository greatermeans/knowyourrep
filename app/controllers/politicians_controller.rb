class PoliticiansController < ApplicationController

  def show
    @politician = Politician.find(params[:id])
  end

  def index
  	if !params['query'].nil?
  	  binding.pry
      @politicians = Politician.send(search_method,search_value).filter_method
    else
      @politicians = Politician.order('Random()').first(10)
  	end
  end

  private

  def query_params
    params.require(:query).permit(:search_value, :filter_by, :search_by)
  end

  def search_method
  	query_params.values[2].split.map(&:downcase).unshift('polit').join('_')
  end

  def search_value
  	query_params.values[0].capitalize
  end

  def filter_method
  	query_params.values[1].split.map(&:downcase).join('_')
  end

end
