FactoryGirl.define do
  factory :user do
    name "Fred"
    email "fred@fred.com"
    street_address "14 bushy ridge rd."
    city "Westport"
    state { State.new(name: "Flatironville", abbreviation: "FV") }
    password "one"
    district_id "583"
  end
end