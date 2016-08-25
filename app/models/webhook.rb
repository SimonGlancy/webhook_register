class Webhook < ApplicationRecord

  validates :address, :email_type, :event, :timestamp, presence: true

  def self.find_total(query_params)
    Webhook.where(query_params).length
  end

  def self.find_percentage(email_type, event_type)
    email_event_total = self.find_total(email_type: email_type, event: event_type).to_f
    email_sent_total = self.find_total(email_type: email_type,event: "send").to_f
    (email_event_total/email_sent_total).round(2)
  end

  def self.create_array_for(event_type)
    result = []
    Webhook.all.each do |webhook|
      if !result.any?{|hash| hash[:type] == webhook.email_type.to_sym}
        result << {type: webhook.email_type.to_sym,
                   rate: self.find_percentage(webhook.email_type, event_type)}
      end
    end
    result
  end

  def self.create_response
    {emails_sent: self.find_total(event: "send"),
     emails_opened: self.find_total(event: "open"),
     emails_clicked: self.find_total(event: "click"),
     open_rate: self.create_array_for("open"),
     click_rate: self.create_array_for("click")}
  end
end
