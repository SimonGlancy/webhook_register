class CreateWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :webhooks do |t|
      t.string :address
      t.string :email_type
      t.string :event
      t.string :timestamp

      t.timestamps
    end
  end
end
