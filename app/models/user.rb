class User < ApplicationRecord
  has_secure_password
  has_many :messages
  belongs_to :district
  belongs_to :state
  has_one :representative_seat
  has_many :senator_seats

  def get_district
  	scraper = Mechanize.new
  	scraper.history_added = Proc.new { sleep 0.5}
  	base_url = 'http://ziplook.house.gov/'
  	form_url = 'http://ziplook.house.gov/htbin/findrep?ADDRLK15170111015170111'

  	scraper.get(form_url) do |search_page|
  		search_form = search_page.form_with(name: 'address') do |search|
  			search['city'] = city
  			search['street'] = street_address
  			search['state'] = state.abbreviation + state.name
  		end
  		@results_page = search_form.submit
  		@district_num = @results_page.search('p').text.split("\n")[9].scan(/[0-9]+/).first
	 end

	district = District.find_by(name: @district_num, state: state)

  end

  def representative
    district.representative_seat.politician
  end

  def senator1
    state.senate_seats[0].politician
  end

  def senator2
    state.senate_seats[1].politician
  end
end

#find or create by states / districts