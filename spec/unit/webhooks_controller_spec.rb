require 'rails_helper'

describe WebhooksController, 'testing routes' do

  def json_response_hash
    {"emails_sent" => 2,
     "emails_opened" => 1,
     "emails_clicked" => 1,
     "open_rate" => [{"type" => "Shipment", "rate" => 1.0}, {"type" => "UserConfirmation", "rate" => 0.0}],
     "click_rate" => [{"type" => "Shipment", "rate" => 0.0}, {"type" => "UserConfirmation", "rate" => 1.0}]}

  end

  def create_request
    {Address:"test@lostmy.name",
     EmailType:"GetABookDiscount",
     Event:"send",
     Timestamp:"1432820696"}
  end

  def create_bad_request
    {Address: nil,
     EmailType: nil,
     Event: nil,
     Timestamp:"1432820696"}
  end

  before(:each) do
    create_data
  end

  describe '#index' do
    it 'shows all webhooks in the database', type: :request do
      get '/'
      json = JSON.parse(response.body)
      expect(json).to eq(json_response_hash)
    end
  end

  describe '#create' do
    it 'allows a new record to be posted to the database', type: :request do
      post '/webhooks', create_request.to_json
      expect(Webhook.last.email_type).to eq("GetABookDiscount")
    end

    it 'does not create an entry if data missing', type: :request do
      post '/webhooks', create_bad_request.to_json
      expect(Webhook.all.length).to eq(4)
      expect(response).to have_http_status(500)
    end
  end
end
