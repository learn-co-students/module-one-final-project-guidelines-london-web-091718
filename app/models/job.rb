class Job < ActiveRecord::Base
  has_many :cityjobs
  has_many :cities, through: :cityjobs

  def self.base_url(description = "", location = "")
    "https://jobs.github.com/positions.json?description=" + description + "&location=" + description
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
