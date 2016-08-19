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
  end
end