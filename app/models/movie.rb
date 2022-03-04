class Movie < ActiveRecord::Base
    def self.with_ratings(ratings)
        self.where('lower(rating) in (?)', ratings.nil? ? ['G','PG','PG-13','R'].map(&:downcase) : ratings.map(&:downcase))
    end
end
