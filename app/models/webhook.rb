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

end
