class WebhooksController < ApplicationController

  respond_to :json

  def index
    render json: Webhook.create_response
  end


end
