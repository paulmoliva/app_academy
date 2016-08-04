class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      redirect_to new_album_url(@album)
    end
  end

  def show
    @album = Album.find_by_id(params[:id])
  end

  def edit
    @album = Album.find_by_id(params[:id])
  end

  def update
    @album = Album.find_by_id(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      redirect_to edit_album_url(@album), notice: @album.errors.full_messages
    end
  end

  def destroy
    @album = Album.find_by_id(params[:id])
  end

  private

  def album_params
    params.require(:album).permit([:title, :album_type, :band_id])
  end
end
