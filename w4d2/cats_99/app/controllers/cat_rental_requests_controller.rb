class CatRentalRequestsController < ApplicationController

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cat_rental_request = CatRentalRequest.new(rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(rental_request_params[:cat_id])
    else
      render :new, notice: @cat_rental_request.errors.full_messages
    end
  end

  private

  def rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end
