class Rating < ActiveRecord::Base
  belongs_to:beer
  
  def to_s
    "#{beer.name} #{score}"
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)
  end
end
