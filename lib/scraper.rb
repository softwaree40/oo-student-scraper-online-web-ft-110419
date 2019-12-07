require 'open-uri'
require 'pry'

class Scraper
  students = []
  def self.scrape_index_page(index_url)
     page = Nokogiri::HTML(open(index_url))
     pages = page.css("div.student-card")
     students = []

      pages.css("div.student-card").each do |student|
      students << {
        name: student.css("div.card-text-container").css("h4.student-name").text.strip,
        location: student.css("div.card-text-container").css("p.student-location").text.strip,
        profile_url: student.css("a").attribute("href").value
      }
    end
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
      page = Nokogiri::HTML(open(index_url))
      pages_profile = page.css("div.social-icon-container").text
      
  end
  binding.pry
end

