class WebhooksController < ApplicationController

  respond_to :json

  def index
    render json: Webhook.all
  end

end
