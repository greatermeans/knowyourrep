require 'pry'
require 'open-uri'
require 'nokogiri'
require 'sanitize'


def run
	get_senators
	index_sens
end

def sen_feed
  "https://en.wikipedia.org/wiki/List_of_current_United_States_Senators"
end


def get_senators
  doc = Nokogiri::HTML(open(sen_feed))
  dirty_senators = (doc.css(".sortable").to_s.split("background-color"))[1..-1]
  senators = clean_senators(dirty_senators)
end

def clean_senators(senators)
  senators.map do |senator| 
    cleaned = (Sanitize.fragment(senator).split("\n")).reject {|item| item == ""}
    cleaned = cleaned[1..-1]
  end
end

def index_sens
  get_senators.each_with_index do |senator|
    set_values_for_sens(senator)
    binding.pry
    new_pol = Politician.create(data_hash_for_sens)
  end
end

def data_hash_for_sens
  {first_name: @first_name,
   last_name: @last_name, party: @party,
   prior_experience: @prior_experience, education: @education, 
   birth_year: @birth_year, email: @email}
end

def set_values_for_sens(senator)
  senator[-3] = nil
  @state = senator[0]
  @class = senator[1]
  names_data = senator[2].scan(/\w+/)
  @first_name = names_data[1][0...(names_data[1].length / 2)]
  @last_name = names_data[0]
  @party = senator[3]
  @prior_experience = senator[4..5].join (", ")
  @education = [senator[6],(senator[7] if senator[7].to_i == 0), (senator[8] if senator[8].to_i == 0)].compact.join(', ')
  # @in_office_since = senator[-2].to_i
  @birth_year = senator[-2][1..4].to_i
  # @senate_or_house = 'House of Representatives'
  @email = "Sen.#{@last_name}@emailcongress.us"
end

run
