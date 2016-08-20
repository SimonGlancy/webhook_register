require "rails_helper"


describe Webhook, "check presentation methods" do

  def model_response_hash
    {emails_sent: 2,
     emails_opened: 1,
     emails_clicked: 1,
     open_rate: {Shipment: 1.0, UserConfirmation: 0.0},
     click_rate: {Shipment: 0.0, UserConfirmation: 1.0}}
  end

  before(:each) do
    create_data
  end

  describe "#find_total(query_params)" do
    it 'returns the total number of emails sent' do
      expect(Webhook.find_total(event: "send")).to eq(2)
    end

    it 'returns the total number of emails clicked' do
      expect(Webhook.find_total(event: "click")).to eq(1)
    end

    it 'returns the total number of emails clicked' do
      expect(Webhook.find_total(event: "open")).to eq(1)
    end

    it 'returns the total number of Shipment emails' do
      expect(Webhook.find_total(email_type: "Shipment")).to eq(2)
    end

    it 'returns the total number of UserConfirmation emails' do
      expect(Webhook.find_total(email_type: "UserConfirmation")).to eq(2)
    end

    it 'returns the total Shipment emails that have been opened' do
      expect(Webhook.find_total(email_type:"Shipment", event:"open")).to eq(1)
    end
  end

  describe "#find_percentage(email_type,event_type)" do
    it 'returns the percentage of opened Shipment emails' do
      expect(Webhook.find_percentage("Shipment", "open")).to eq(1.0)
    end
  end

  describe "#create_hash_for(event_type)" do
    it 'returns a hash for the click percentage' do
      expect(Webhook.create_hash_for("click")).to eq(({Shipment: 0, UserConfirmation: 1.0}))
    end

    it 'returns a hash for the open percentage' do
      expect(Webhook.create_hash_for("open")).to eq(({Shipment: 1.0, UserConfirmation: 0}))
    end
  end

  describe "#create_response" do
    it 'returns the hash to be sent to the index route' do
      expect(Webhook.create_response).to eq(model_response_hash)
    end
  end

end
