class Politician < ApplicationRecord

  has_one :representative_seat
  has_one :senate_seat
  has_many :messages

  def full_name
  	[first_name, last_name].join(' ')
  end

  def image_name
    [first_name, last_name + '.jpg'].join('_')
  end

  def age
  	Time.now.year - birth_year
  end

  def senate_or_house
  	representative_seat.nil? ? senate : house
  end

  def senate
  	'Member of the United States Senate'
  end

  def house
  	"Member of the United States House of Representatives from #{representative_seat.district.state.name}'s 
  		#{representative_seat.district.name.to_i.ordinalize} district"
  end

  SEARCH_BY = ['Over An Age','Under An Age','By Age','By Education'] 
  FILTER_BY = ['Senators','House of Reps','Democrat','Republican','All']
  ##QUERIES ADD ^ HERE


  def self.republican
    where(party: 'Republican')
  end

  def self.democrat
    where(party: 'Democrat')
  end

  def self.house_of_reps
    joins(:representative_seat)
  end

  def self.senators
    joins(:senate_seat)
  end

  def self.polit_over_an_age(age)
    where('birth_year > ?',"#{Time.now.year - age.to_i}")
  end

  def self.polit_under_an_age(age)
    where('birth_year > ?',"#{Time.now.year - age.to_i}")
  end

  def self.polit_over_an_age(age)
    where('birth_year < ?',"#{Time.now.year - age.to_i}")
  end

  def self.polit_by_age(age)
    where('birth_year = ?',"#{Time.now.year - age.to_i}")
  end

  def self.polit_by_education(school)
    Politician.where('education LIKE ?', "%#{school.capitalize}%")
  end



end
