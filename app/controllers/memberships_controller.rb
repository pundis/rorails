class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy, :create, :new]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end


  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)

    if @membership.save
      current_user.memberships << @membership
      flash[:notice] = "#{current_user.username}, welcome to the club!"
      redirect_to beer_club_path @membership.beer_club
    else
      render :new
    end
  end


  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_membership
	@beerclubs = BeerClub.all   
    end
end
