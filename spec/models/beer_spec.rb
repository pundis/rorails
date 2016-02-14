require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved to the database with a name and style" do
    beer = Beer.create name:"TBeer", style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
 
  it "cant be saved without a name" do
    beer = Beer.create style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(0)
  end

  it "cant be saved without a style" do
    beer = Beer.create name:"Tbeer"
    
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end

