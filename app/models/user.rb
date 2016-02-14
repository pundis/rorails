class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }

  validates :password, length: { minimum: 4 },
                       format: {
                          with: /\d.*[A-Z]|[A-Z].*\d/,
                          message: "has to contain one number and one upper case letter"
                       }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  has_secure_password

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end

	def favorite_style
		return nil if ratings.empty?
		get_liked_styles.max_by{|k,v| v}.first
	end

	def get_liked_styles
		averages = Hash.new
		rated_styles.each do |key,style|
			averages[key] = rated_styles[key].collect{ |i| i.score }.reduce(:+)/rated_styles[key].count.to_f
		end
		averages
	end

	def rated_styles
		ratings.group_by { |i| i.beer.style }
	end

	def favorite_brewery
		return nil if ratings.empty?
		get_liked_breweries.max_by{|k,v| v}.first
	end

	def get_liked_breweries
		averages = Hash.new
		rated_breweries.each do |key,brewery|
			averages[key] = rated_breweries[key].collect{ |i| i.score }.reduce(:+)/rated_breweries[key].count.to_f
		end
		averages
	end

	def rated_breweries
		ratings.group_by { |i| i.beer.brewery }
	end

end
