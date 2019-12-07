require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url
    #name: doc.css("div.student-card").css("div.card-text-container").css("h4.student-name").text
    # location: doc.css("div.student-card").css("div.card-text-container").css("p.student-location").text
    # profile_url: doc.css("div.student-card").css("a").attribute("href").value

     # profile_url: index_url.gsub("index.html", student.css("a").attribute("href").value )
    students = []

    doc.css("div.student-card").each do |student|
      students << {
        name: student.css("div.card-text-container").css("h4.student-name").text.strip,
        location: student.css("div.card-text-container").css("p.student-location").text.strip,
        profile_url: student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css("div.social-icon-container a").collect do |l|
      l.attribute('href').text
    end
    student = {}

    # add social links
    social_links.each do |link|
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

    # add profile quote & bio
    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.bio-content.content-holder").css("div.description-holder p").text

    student
  end
end