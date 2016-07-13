require 'open-uri'


def run_sen
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
  get_senators.each do |senator|
    @senator = senator
    set_values_for_sens
    # grab_photos_sen
    @new_pol = Politician.create(data_hash_for_polit_sen)
    SenateSeat.create(data_hash_for_senator)
  end
end

def data_hash_for_polit_sen
  {first_name: @first_name,
   last_name: @last_name, party: @party,
   prior_experience: @prior_experience, education: @education,
   birth_year: @birth_year, email: @email, state_id:@state.id}
end

def data_hash_for_senator
  {politician_id: @new_pol.id, state_id: @state.id, class_num: @class,
   held_since: @held_since}
end

def set_values_for_sens
  @senator[-3] = nil
  @state = State.find_or_create_by(name: @senator[0])
  @class = @senator[1]
  set_names_for_sens
  @party = @senator[3]
  fix_for_prior_exp
  @education = [@senator[6],(@senator[7] if @senator[7].to_i == 0),
                (@senator[8] if @senator[8].to_i == 0)].compact.join(', ')
  @birth_year = @senator[-2][1..4].to_i
  @email = "Sen.#{@last_name}@emailcongress.us"
end

def fix_for_prior_exp
  @prior_experience = [(@senator[4] if !@senator[4].split.include?("unknown/missing.")),
                      @senator[5]].compact.join(", ")
end

def set_names_for_sens
  names_data = @senator[2].scan(/\w+/)
  return if names_data.count == 1
  @last_name = names_data[0]
  if names_data.length > 3
    @first_name = names_data[1] + names_data[2]
  else
    @first_name = names_data[1][0...(names_data[1].length / 2)]
  end
end

def polit_url_sen
  "https://en.wikipedia.org/wiki/#{@first_name.split(' ').join('_')}_#{@last_name}"
end

def grab_photos_sen
  begin
    root_dir = Rails.root.join('app','assets','images',[@first_name,
                                                      @last_name + '.jpg'].join('_'))
    sources = Nokogiri::HTML(open(polit_url_sen)).xpath("//img/@src")
    src = sources.find {|source| source if source.value.scan(@first_name).count > 0}
    uri = URI.join( polit_url_sen, src ).to_s

    File.open(root_dir,'wb') { |f| f.write(open(uri).read)}
  rescue Exception => e
    puts "Error #{e} for #{@first_name} #{@last_name}"
  end
end
