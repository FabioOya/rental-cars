class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all  
  end

  def show
    id = params[:id]
    @manufacturer = Manufacturer.find(id)
    if @manufacturer.id = nil
        flash[:alert] = 'Nenhum fabricante cadastrado'
        render :new
    end
  end
end