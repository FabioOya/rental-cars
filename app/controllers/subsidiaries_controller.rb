class SubsidiariesController < ApplicationController
  #before_action :authenticate_user!
  #before_action :authorize_admin
  #before_action :set_subsidiary, only: %i[show edit update]

  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(params.require(:subsidiary).permit(:name, :cnpj, :adress))
    return redirect_to @subsidiary if @subsidiary.save

    render :new
  end

  # def set_subsidiary
  #   @subsidiary = Subisidiary.find(params[:id])
  # end

  # def authorize_admin
  #   redirect_to root_path, notice: 'Não autorizado' unless current_user.admin?
  # end
end
