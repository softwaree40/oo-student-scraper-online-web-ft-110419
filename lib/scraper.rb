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
      location: student.css("div.card-text-container p.student-location")
      profile_url: student.css("a").attribute("href").value
      }
       binding.pry
     
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

