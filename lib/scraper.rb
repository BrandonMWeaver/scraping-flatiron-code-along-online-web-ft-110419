require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  def get_page
    return Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    return get_page.css(".posts-holder")
  end
  
  def make_courses
    self.get_courses.each { |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    }
  end
  
  def print_courses
    self.make_courses
    Course.all.each { |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    }
  end
end
