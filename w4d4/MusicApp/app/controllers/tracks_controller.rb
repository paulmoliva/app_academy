class TracksController < ApplicationController
  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      redirect_to new_track_url(@track)
    end
  end

  def show
    @track = Track.find_by_id(params[:id])
  end

  def edit
    @track = Track.find_by_id(params[:id])
  end

  def update
    @track = Track.find_by_id(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      redirect_to edit_track_url(@track), notice: @track.errors.full_messages
    end
  end

  def destroy
    @track = Track.find_by_id(params[:id])
  end

  private

  def track_params
    params.require(:track).permit([:title, :track_type, :album_id])
  end
end
