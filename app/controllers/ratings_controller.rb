class RatingsController < ApplicationController
  def index
        #käynnistän config/boot.rb :ssä uuden threadin joka 
        #eventual consistency-mallin mukaisesti pitää huolta cachen "ajantasaisuudesta"
        @breweries = Rails.cache.read "brewery top 3"
        @beers = Rails.cache.read "beer top 3"
        @styles = Rails.cache.read "style top 3"
        @users = Rails.cache.read "user most active 3"
        @ratings = Rails.cache.read "all ratings"
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating  ## virheen aiheuttanut rivi
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

private


end  