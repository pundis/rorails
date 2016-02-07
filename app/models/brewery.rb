class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  validates :year, numericality: { 
    		   only_integer: true,
		   greater_than_or_equal_to: 1042,
  }

  validate :year_cant_be_in_the_future

    def year_cant_be_in_the_future
      if year > Time.new.year
	errors.add(:year, "can't be in the future")
      end
    end
end
