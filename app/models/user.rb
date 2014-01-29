class User < ActiveRecord::Base
  #add mailboxer methods
  acts_as_messageable

  has_one :subscription
  has_one :plan, :through => :subscription
  has_many :projects, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_type, presence: true

  validates :username, presence: true
  validates_uniqueness_of :username
 

  def full_name
      first_name + " " + last_name
  end

  def name
    self.id  
  end

  def initiate_conversation(recipient, subject, body)
    self.send_message(recipient, subject, body)
    self.increment!(:conversations_initiated)
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
