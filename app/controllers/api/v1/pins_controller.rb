class Api::V1::PinsController < ApplicationController
  def index
    render json: Pin.all.order('created_at DESC')
  end

  def create
    pin = Pin.new(pin_params)
    if pin.save
      render json: pin, status: 201
    else
      render json: { errors: pin.errors }, status: 422
    end
  end

  private


    def restrict_access 
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end 
    end 



    def pin_params
      params.require(:pin).permit(:title, :image_url)
    end
end