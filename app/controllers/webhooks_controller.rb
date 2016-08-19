class WebhooksController < ApplicationController

  respond_to :json

  def index
    render json: Webhook.create_response
  end

  def create
    respond_with Webhook.create(webhook_params), status: 200
  end

  def webhook_params
    params.permit(:address, :email_type, :event, :timestamp)
  end

end
