require "rails_helper"


describe Webhook, "check presentation methods" do
  before(:each) do
    @webhook1 = Webhook.create(address:"barney@lostmy.name",email_type:"Shipment",event:"send",timestamp:1432820696)
    @webhook2 = Webhook.create(address:"tom@lostmy.name",email_type:"UserConfirmation",event:"click",timestamp:1432820702)
    @webhook3 = Webhook.create(address:"vitor@lostmy.name",email_type:"Shipment",event:"open",timestamp:1432820704)
  end

  describe "#find_total(query_params)" do
    it 'returns the total number of emails sent' do
      expect(Webhook.find_total(event: "send")).to eq(1)
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
      expect(Webhook.find_total(email_type: "UserConfirmation")).to eq(1)
    end

    it 'returns the total Shipment emails that have been opened' do
      expect(Webhook.find_total(email_type:"Shipment", event:"open")).to eq(1)
    end
  end

  describe "#find_percentage(email_type,event_type)" do
    expect(Webhook.find_percentage("Shipment", "send"))
  end

end
