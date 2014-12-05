class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date


def self.all_ratings
  Array['G','PG','PG-13','R','NC-17']
end

def Movie.get_all_ratings
	all_ratings = []
	self.select(:rating).group(:rating).each do |mo|
		all_ratings << mo.rating
	end
	return all_ratings
end
end
