class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params.require(:customer).permit(:name, :document, :email))
    @customer.save
    redirect_to customer_path(Customer.last.id)
  end

  def search
    #@customers = Customer.where('name LIKE ?', "%#{params[:q]}%")
    @customers = Customer.search(params[:q])
    render :index
  end
end