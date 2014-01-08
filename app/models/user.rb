class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :subscription
  has_one :plan, :through => :subscription

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_type, presence: true

  def full_name
      first_name + " " + last_name
  end
 
end
