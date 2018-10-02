class Job < ActiveRecord::Base
  has_many :cityjobs
  has_many :cities, through: :cityjobs

  def self.base_url(description = "", location = "")
    "https://jobs.github.com/positions.json?description=" + description + "&location=" + description
  end

  def self.format_result(data, i, verbose = false)
    puts Rainbow("#{i} ====================================================================").yellow
    puts Rainbow("Title: ").red + data["title"]
    puts Rainbow("Company: ").red + data["company"]
    puts Rainbow("Location: ").red + data["location"]
    puts Rainbow("Date added: ").red + data["created_at"]
    des = ''
    easyTAPI_key = 'AIzaSyAuWrOhCrtnEaoABagC6r0EpGN4OdQP8qU'
    if verbose
      des = data["description"]
      puts Rainbow("Description: ").red + des
      # puts Rainbow("Description: ").red + EasyTranslate.translate(des, :to => :en, :key => easyTAPI_key)
      # puts "URL: " + data["url"].gsub(URI.regexp, '<a href="\0">\0</a>')
      puts ""
      # puts Rainbow("Company Website: ").red + data["company_url"]
      puts ""
      # puts Rainbow("Company Logo: ").red + data["company_logo"]
      # puts ""
      #ADD LOGO GEM https://github.com/pazdera/catpix
      puts Rainbow("URL: ").red + data["url"]
      puts ""
    else
      des = data["description"][0..100].split("<p>").join("</p>").split("</p>").join("<br>").split("<br>").join("<ul>").split("<ul>").join("<li>").split("<li>").join("<h1>").split("<h1>").join("<h4>").split("<h4>").join("")
      puts Rainbow("Description: ").red + des + "..."
      # puts Rainbow("Description: ").red + EasyTranslate.translate(des, :to => :en, :key => easyTAPI_key) + "..."
      puts ""
    end
    #add <i> , <br> etc
  end

  def self.most_popular_cities
  end

  def self.full_time_roles
  end

  def self.best_quality_of_life_score
  end

  def self.latest_job_posts

  end

end
