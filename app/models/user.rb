class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true, length: {minimum: 3}

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

end
