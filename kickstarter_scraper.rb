# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  # Projects: kickstarter.css('li.project.grid_4')
  # Title: kickstarter.css('h2.bbcard_name strong a').text
  # Image Link: kickstarter.css('div.project-thumbnail a img').attribute('src').value
  # Description: kickstarter.css('p.bbcard_blurb').text
  # Location: kickstarter.css('span.location-name').text
  # percent_funded: kickstarter.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  projects = {}
  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      :image_link => project.css('div.project-thumbnail a img').attribute('src').value,
      :description => project.css('p.bbcard_blurb').text,
      :location => project.css('span.location-name').text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects

end
