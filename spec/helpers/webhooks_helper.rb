def create_data
  @webhook1 = Webhook.create(address:"barney@lostmy.name",email_type:"Shipment",event:"send",timestamp:1432820696)
  @webhook2 = Webhook.create(address:"tom@lostmy.name",email_type:"UserConfirmation",event:"send",timestamp:1432820702)
  @webhook3 = Webhook.create(address:"vitor@lostmy.name",email_type:"Shipment",event:"open",timestamp:1432820704)
  @webhook4 = Webhook.create(address:"tom@lostmy.name",email_type:"UserConfirmation",event:"click",timestamp:1432820702)
  response_hash = {emails_sent: 2,
                    emails_opened: 1,
                    emails_clicked: 1,
                    open_rate: {Shipment: 1.0, UserConfirmation: 0.0},
                    click_rate: {Shipment: 0.0, UserConfirmation: 1.0}}
end
