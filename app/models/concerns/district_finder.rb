module DistrictFinder

    def get_district
      scraper = Mechanize.new
      scraper.history_added = Proc.new { sleep 0.5}
      base_url = 'http://ziplook.house.gov/'
      form_url = 'http://ziplook.house.gov/htbin/findrep?ADDRLK15170111015170111'

      scraper.get(form_url) do |search_page|
        search_form = search_page.form_with(name: 'address') do |search|
          search['city'] = city
          search['street'] = street_address
          search['state'] = self.state.abbreviation + self.state.name
        end
        @results_page = search_form.submit
        @district_num = @results_page.search('p').text.split('Congressional')[0].split.last.scan(/[0-9]+/)
      end
      self.district = District.find_by(name: @district_num, state: self.state)
    end
end
