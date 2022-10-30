class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show update destroy ]

  def show
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render :show, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    if @client.update(client_params)
      debugger
      render :show, status: :ok, location: @client
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
      params.require(:client).permit(:name, :age, :private_node, :address)
    end
end
