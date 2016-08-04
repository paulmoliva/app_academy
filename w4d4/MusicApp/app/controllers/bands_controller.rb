class BandsController < ApplicationController
  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      redirect_to new_band_url(@band), notice: @band.errors.full_messages
    end
  end

  def show
    @band = Band.find_by_id(params[:id])
  end

  def edit
    @band = Band.find_by_id(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      redirect_to edit_band_url(@band), notice: @band.errors.full_messages
    end
  end

  def destroy
    @band = Band.find_by_id(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  def index
    @bands = Band.all
  end

  private

  def band_params
    params.require(:band).permit([:name])
  end
end
