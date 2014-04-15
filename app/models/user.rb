class User < ActiveRecord::Base
  #add mailboxer methods
  acts_as_messageable

  has_one :subscription
  has_one :plan, :through => :subscription
  has_one :profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_type, presence: true

  validates :username, presence: true
  validates_uniqueness_of :username

  def full_name
      first_name + " " + last_name
  end
  
  def has_unread_messages?
    self.mailbox.conversations(:unread => true).any?
  end

  def unread_messages_count
    self.mailbox.conversations(:unread => true).count.to_s
  end
  
  def admin?
    self.admin
  end

  def investor?
    self.user_type == "investor"
  end

  def entrepreneur?
    self.user_type == "entrepreneur"
  end

  def name
    self.id  
  end

  def initiate_conversation(recipient, subject, body)
    if conversation_initiations_remaining > 0
      self.send_message(recipient, subject, body)
      self.increment!(:conversations_initiated)
    else
      false
    end
  end

  def conversation_initiations_remaining
    if self.subscription
      self.subscription.plan.user_conversation_limit - self.conversations_initiated
    else
      0
    end
  end

  def mailboxer_email(object)
  end
 
end
