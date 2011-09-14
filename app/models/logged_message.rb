class LoggedMessage < ActiveRecord::Base
  belongs_to :group
  belongs_to :sender, :polymorphic=>true

  validates_phone_number :source_phone, :allow_blank=>true #can be sent from website
  validates_phone_number :destination_phone

  validates_presence_of :message

  attr_readonly :source_phone, :destination_phone, :message #can't edit after the fact

  def self.unique_messages
    select("max(created_at) as created_at, message, count(*) as recipient_count").group("message")
  end
end
