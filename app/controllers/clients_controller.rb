class ClientsController < ApplicationController
  before_action :set_client, only: %i[ destroy ]
  
  def create
    @client = Client.new(client_params)

    if @client.save
      render :show, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :age, :private_note, :address)
    end
end
