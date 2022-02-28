class Movie < ActiveRecord::Base
    def self.with_ratings(ratings)
        self.where('lower(rating) in (?)', ratings.map(&:downcase))
    end
end