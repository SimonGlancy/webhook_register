class WebhooksController < ApplicationController

  def index
    render json: Webhook.create_response
  end

  def create
    json_params = JSON.parse(request.body.read)
    new_entry =  Webhook.new(address: json_params["Address"],
                                email_type: json_params["EmailType"],
                                event: json_params["Event"],
                                timestamp: json_params["Timestamp"])
    new_entry.save ? (render html: "SUCCESS", status: 200) : (render html: "ERROR", status: 500)
  end
end
