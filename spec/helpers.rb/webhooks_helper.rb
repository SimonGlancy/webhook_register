

def create_data
  @webhook1 = Webhook.create(address:"barney@lostmy.name",email_type:"Shipment",event:"send",timestamp:1432820696)
  @webhook2 = Webhook.create(address:"tom@lostmy.name",email_type:"UserConfirmation",event:"send",timestamp:1432820702)
  @webhook3 = Webhook.create(address:"vitor@lostmy.name",email_type:"Shipment",event:"open",timestamp:1432820704)
  @webhook4 = Webhook.create(address:"tom@lostmy.name",email_type:"UserConfirmation",event:"click",timestamp:1432820702)
end
