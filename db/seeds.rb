#wtf

def run
  set_scraper
  get_reps
  index_polits
end

def set_scraper
  @scraper = Mechanize.new
end

def polit_url(politician)
  "https://en.wikipedia.org/wiki/#{politician.first_name.split(' ').join('_')}_#{politician.last_name}"
end

def get_photos
  set_scraper
  Politician.all.each do |politician|
    page = @scraper.get(polit_url(politician))
  end
end

def grab_photos
  root_dir = Rails.root.join('app','assets','images',[politician.first_name,
                                                      politician.last_name + '.jpg'].join('_'))
  src = Nokogiri::HTML(open(polit_url(politician))).xpath("//img/@src").first
  uri = URI.join( polit_url(politician), src ).to_s

  File.open(root_dir,'wb') { |f| f.write(open(uri).read)}
end

def reps_feed
  'https://en.wikipedia.org/wiki/Current_members_of_the_United_States_House_of_Representatives'
end

def get_reps
  page = @scraper.get(reps_feed)
  @raw_data = page.search('tr')
  binding.pry
end

def index_polits
  @raw_data.each_with_index do |row,idx|
    @row_data = row.children.text.split("\n")
    set_values_for_polit if invalid_data(idx)
    @politician = Politician.create(data_hash_for_polit) if invalid_data(idx)
    create_rep_seats
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
end

def create_rep_seats
  @held_since = @row_data[-2].to_i
  @term_ends = Time.current.year.even? ? Time.current.year : (Time.current.year + 1)
  RepresentativeSeat.create(data_hash_for_reps)
end

def set_names_for_polit
  names_data = @row_data[4].scan(/\w+/)
  return if names_data.count == 1
  @last_name = names_data[0]
  if names_data.length > 3
    @first_name = names_data[1] + names_data[2]
  else
    @first_name = names_data[1][0...(names_data[1].length / 2)]
  end
end

Politician.destroy_all
RepresentativeSeat.destroy_all
State.destroy_all
District.destroy_all
run

# get_photos
