require 'rails_helper'

describe WebhooksController, 'testing routes' do
  before(:each) do

    @webhook1 = Webhook.create(address:"barney@lostmy.name",email_type:"Shipment",event:"send",timestamp:1432820696)
    @webhook2 = Webhook.create(address:"tom@lostmy.name",email_type:"UserConfirmation",event:"click",timestamp:1432820702)
    @webhook3 = Webhook.create(address:"vitor@lostmy.name",email_type:"Shipment",event:"open",timestamp:1432820704)
  end


  describe '#index' do
    it 'shows all webhooks in the database', type: :request do
      get '/'
      json = JSON.parse(response.body)
      expect(json.length).to eq(3)
    end
  end
end
