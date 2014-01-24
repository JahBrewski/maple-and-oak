class User < ActiveRecord::Base
  #add mailboxer methods
  acts_as_messageable

  has_one :subscription
  has_one :plan, :through => :subscription
  has_many :projects, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_type, presence: true

  def full_name
      first_name + " " + last_name
  end

  def name
    self.id  
  end

  def mailboxer_email(object)
  end
 
end
