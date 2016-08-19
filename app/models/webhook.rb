class Webhook < ApplicationRecord

  def as_json(options={})
    super(only: [:address,
                 :email_type,
                 :event,
                 :timestamp])
  end

  def self.find_total(query_params)
    Webhook.where(query_params).length
  end

  def self.find_percentage(email_type, event_type)
    event_total = self.find_total(email_type: email_type, event: event_type).to_f
    email_total = self.find_total(email_type: email_type).to_f

    (event_total/email_total).round(2)
  end


end
