require 'open-uri'
require 'pry'

class Scraper
       students={}
  def self.scrape_index_page(index_url)
     page = Nokogiri::HTML(open(index_url))
     pages = page.css("div.student-card")
      page.css("div.student-card").each do |student|
      students << {
      name: student.css("div.card-text-container h4.student-name")
      location: student.css()
      }
       binding.pry
     
      end
      
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

