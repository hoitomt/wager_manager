class ClientsController < ApplicationController
  def index
    @clients = current_user.clients.order(:last_name)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = current_user.clients.create(client_params)
    if @client.valid?
      redirect_to clients_path
    else
      render :new
    end
  end

  def destroy
    @client = Client.find(params[:id])
    unless @client.destroy
      flash[:error] = "There was a problem deleting #{@client.full_name}"
    end
    redirect_to clients_path
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :email)
  end
end
