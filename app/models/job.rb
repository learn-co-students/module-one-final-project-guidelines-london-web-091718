class Job < ActiveRecord::Base
  has_many :cityjobs
  has_many :cities, through: :cityjobs

  def self.base_url(description = "", location = "")
    "https://jobs.github.com/positions.json?description=" + description + "&location=" + description
  end

  def self.format_result(data, i, verbose = false)
    puts Rainbow("#{i}====================================================================").yellow
    puts Rainbow("Title: ").red + data["title"]
    puts Rainbow("Location: ").red + data["location"]
    puts Rainbow("Date added: ").red + data["created_at"]
    des = data["description"][0..100].split("<p>").join("</p>").split("</p>").join("<br>").split("<br>").join("<ul>").split("<ul>").join("<li>").split("<li>").join("<h1>").split("<h1>").join("<h4>").split("<h4>").join("")
    # puts Rainbow("Description: ").red + EasyTranslate.translate(des, :to => :en)
    puts Rainbow("Description: ").red + des + "..."
    #add <i> , <br> etc
    puts ""
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
