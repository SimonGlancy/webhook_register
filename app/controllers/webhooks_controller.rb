class WebhooksController < ApplicationController

  respond_to :json

  def index
    render json: Webhook.create_response
  end

  def create
    check_webhook_params ? create_from_webhook_params : create_from_json_params
  end

  private

  def check_webhook_params
    params.has_key?(:webhook)
  end

  def webhook_params
    params.require(:webhook).permit(:address, :email_type, :event, :timestamp)
  end

  def create_from_json_params
    json_params = JSON.parse(request.body.read)
    respond_with Webhook.create(address: json_params["Address"],
                                email_type: json_params["EmailType"],
                                event: json_params["Event"],
                                timestamp: json_params["Timestamp"]), status: 200
  end

  def create_from_webhook_params
    respond_with Webhook.create(webhook_params)
  end

end
