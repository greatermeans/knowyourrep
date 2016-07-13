# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def run
	set_scraper
	get_reps
	index_reps
end

def set_scraper
  @scraper = Mechanize.new
end

def reps_feed
  'https://en.wikipedia.org/wiki/Current_members_of_the_United_States_House_of_Representatives'
end

def get_reps
  page = @scraper.get(reps_feed)
  @raw_data = page.search('tr')
  binding.pry
end

def index_reps
  @raw_data.each_with_index do |row,idx|
    row_data = row.children.text.split("\n")
    binding.pry
    set_values_for_reps(row_data) if idx > 91 && idx < 534 && idx != 527
    Politician.create(data_hash_for_reps) if idx > 91 && idx < 534 && idx != 527
  end
end

# def data_hash_for_reps
#   {district: @district, state: @state, first_name: @first_name,
#    last_name: @last_name, party: @party, religion: @religion,
#    prior_experience: @prior_experience, education: @education,
#    in_office_since: @in_office_since, birth_year: @birth_year,
#    senate_or_house: @senate_or_house, email: @email}
# end

def data_hash_for_reps
  {first_name: @first_name,
   last_name: @last_name, party: @party, religion: @religion,
   prior_experience: @prior_experience, education: @education, 
   birth_year: @birth_year, email: @email}
end

def set_values_for_reps(row_data)
  @district = row_data[2]
  @state = @district.split(' ').first
  names_data = row_data[4].scan(/\w+/)
  @first_name = names_data[1][0...(names_data[1].length / 2)]
  @last_name = names_data[0]
  @party = row_data[5]
  @religion = row_data[6]
  @prior_experience = row_data[7]
  @education = [row_data[8],(row_data[9] if row_data[9].to_i == 0), (row_data[10] if row_data[10].to_i == 0)].compact.join(', ')
  # @in_office_since = row_data[-2].to_i
  @birth_year = row_data.last.to_i
  # @senate_or_house = 'House of Representatives'
  @email = "Rep.#{@last_name}@emailcongress.us"
end

run
