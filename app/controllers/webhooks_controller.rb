class WebhooksController < ApplicationController

  respond_to :json

  def index
    render json: Webhook.create_response
  end

  def create
    json_params = JSON.parse(request.body.read)
    respond_with Webhook.create(address: json_params["Address"],
                                email_type: json_params["EmailType"],
                                event: json_params["Event"],
                                timestamp: json_params["Timestamp"]), status: 200
  end
end
