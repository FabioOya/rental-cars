class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all  
  end

  def show
    id = params[:id]
    @manufacturer = Manufacturer.find(id)
  end

  def new
    @manufacturer = Manufacturer.new
  end
  
  def create
    @manufacturer = Manufacturer.new(params.require(:manufacturer).permit(:name))
    @manufacturer.save
    redirect_to manufacturer_path(Manufacturer.last.id)
  end
end