class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update, :destroy]

  # GET /addresses
  def index
    @address = Address.all
    render json: @address
  end

  # GET /addresses/1
  def show
    render json: @address
  end

  # POST /addressess
  def create
    @address = Address.new(address_params)

    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @post.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @post.destroy
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:post).permit(:first_name, :last_name, :country, :experiences)
  end
end
