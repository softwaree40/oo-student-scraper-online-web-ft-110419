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
      social_link = Nokogiri::HTML(open(profile_url))
      pages_profile = social_link.css("div.social-icon-container a")
      collected_link = pages_profile.collect do |link|
      link.attribute("href")
      
     end
     binding.pry
  end
     student = {}
     collected_link.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      else
        student[:blog] = link
      end
    end
     student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.bio-content.content-holder").css("div.description-holder p").text

    student
  end
      
end

