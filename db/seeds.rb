require_relative 'senseeds.rb'

def run
  set_scraper
  get_reps
  index_polits
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
end

def index_polits
  @raw_data.each_with_index do |row,idx|
    @row_data = row.children.text.split("\n")
    if invalid_data(idx)
      set_values_for_polit 
      @url = 'https://en.wikipedia.org' + row.search('a')[2].attributes.first.last.value
      # grab_photos
      @politician = Politician.create(data_hash_for_polit)
      create_rep_seats
    end
  end
end

def invalid_data(idx)
  idx > 91 && idx < 527 && idx != 417
end

def data_hash_for_reps
  {district: @district, politician: @politician,
   held_since: @held_since,term_ends: @term_ends
   }
end

def data_hash_for_polit
  {first_name: @first_name, last_name: @last_name, party: @party,
   prior_experience: @prior_experience, education: @education,
   birth_year: @birth_year, email: @email,
   state: @state, in_office?: @in_office
   }
end

def set_values_for_polit
  @state_district = @row_data[2].split(' ')
  create_states
  create_districts
  set_names_for_polit
  if !@last_name.nil?
    @party = @row_data[5]
    @religion = @row_data[6]
    @prior_experience = @row_data[7]
    @education = [@row_data[8],(@row_data[9] if @row_data[9].to_i == 0), (@row_data[10] if @row_data[10].to_i == 0)].compact.join(', ')
    @birth_year = @row_data.last.to_i
    @email = "Rep.#{@last_name}@emailcongress.us"
  end
end

def create_districts
  @district = District.create(name: @state_district.last, state: @state)
end

def create_states
 @state = [@state_district.first,
           (@state_district[1] if @state_district[1].to_i == 0)].compact.join(' ')
 @state = State.find_or_create_by(name: @state)
 @state.abbreviation = state_abbreviation_hash["#{@state.name}"]
 @state.save
end

def create_rep_seats
  @held_since = @row_data[-2].to_i
  @term_ends = Time.current.year.even? ? Time.current.year : (Time.current.year + 1)
  RepresentativeSeat.create(data_hash_for_reps)
end

def set_names_for_polit
  @names_data = @row_data[4].scan(/\w+/)
  return if @names_data.count == 1
  @last_name = @names_data[0]
  if @names_data.length > 3
    @first_name = @names_data[1] + @names_data[2]
  else
    @first_name = @names_data[1][0...(@names_data[1].length / 2)]
  end
end

def grab_photos
  begin
    root_dir = Rails.root.join('app','assets','images',[@first_name,
                                                      @last_name + '.jpg'].join('_'))
    sources = Nokogiri::HTML(open(polit_url)).xpath("//img/@src")
    src = sources.find {|source| source if source.value.scan(@first_name).count > 0}
    uri = URI.join( polit_url, src ).to_s
    ury = URI.join( @url, src ).to_s
    File.open(root_dir,'wb') { |f| f.write(open(ury).read)}
  rescue Exception => e
    puts "Error #{e} for #{@first_name} #{@last_name}"
  end
end

def polit_url
  "https://en.wikipedia.org/wiki/#{@first_name.split(' ').join('_')}_#{@last_name}"
end


def state_abbreviation_hash
 {"Alabama" => "AL", "Alaska" => "AK", "Arizona" => "AZ", "Arkansas" => "AR", 
  "California" => "CA",  "Colorado" => "CO", "Connecticut" => "CT", "Delaware" => "DE", 
  "Florida" => "FL", "Georgia" => "GA", "Hawaii" => "HI", "Idaho" => "ID", "Illinois" => "IL", 
  "Indiana" => "IN", "Iowa" => "IA", "Kansas" => "KS", "Kentucky" => "KY", "Louisiana" => "LA", 
  "Maine" => "ME", "Maryland" => "MD", "Massachusetts" => "MA", "Michigan" => "MI", 
  "Minnesota" => "MN", "Mississippi" => "MS", "Missouri" => "MO", "Montana" => "MT", 
  "Nebraska" => "NE", "Nevada" => "NV", "New Hampshire" => "NH", "New Jersey" => "NJ", 
  "New Mexico" => "NM", "New York" => "NY", "North Carolina" => "NC", "North Dakota" => "ND", 
  "Ohio" => "OH", "Oklahoma" => "OK", "Oregon" => "OR", "Pennsylvania" => "PA", 
  "Rhode Island" => "RI", "South Carolina" => "SC", "South Dakota" => "SD", 
  "Tennessee" => "TN", "Texas" => "TX", "Utah" => "UT", "Vermont" => "VT", 
  "Virginia" => "VA", "Washington" => "WA", "West Virginia" => "WV", 
  "Wisconsin" => "WI", "Wyoming" => "WY"}
end


Politician.destroy_all
RepresentativeSeat.destroy_all
State.destroy_all
District.destroy_all
SenateSeat.destroy_all
run
run_sen
District.create(name: '10',state:(State.find_by(name:'Pennsylvania')))

User.create(name: 'Jon Log', password: 'one', email: 'jonlog@gmail.com', street_address: '11 Broadway', city: 'New York', state: State.find_by(name: 'New York'), district: '1')
User.create(name: 'Jeremy Won', password: 'one', email: 'jeremywon@aol.com', street_address: '2611 N Central Ave', city: 'Phoenix', state: State.find_by(name: 'Arizona'), district: '1')
User.create(name: 'Lea Bent', password: 'one', email: 'leabent@gmail.com', street_address: '15 Twilight Dr', city: 'Foxboro', state: State.find_by(name: 'Massachusetts'), district: '1')
User.create(name: 'Irene Left', password: 'one', email: 'ireneleft@gmail.com', street_address: '132 N Main St', city: 'Concord', state: State.find_by(name: 'New Hampshire'), district: '1')
User.create(name: 'Willy Wonka', password: 'one', email: 'willywonka@gmail.com', street_address: '2801 Main St', city: 'Irvine', state: State.find_by(name: 'California'), district: '1')



