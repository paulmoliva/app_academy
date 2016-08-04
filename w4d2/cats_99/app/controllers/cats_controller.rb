class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    @cat_rental_requests = @cat.cat_rental_requests
    # render :show @cat
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_path(@cat)
    else
      redirect_to edit_cat_url, notice: @cat.errors.full_messages
    end
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new, notice: @cat.errors.full_messages
    end
  end

  def approve
    @request = CatRentalRequest.find_by_id(params[:id])
    @request.approve!
    redirect_to back(fallback_location: root_path)
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :description, :birth_date, :color, :id)
  end
end
