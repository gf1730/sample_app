# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation

  has_many :microposts, dependent: :destroy
  has_secure_password

  before_save :create_user_token

  validates :name,
    presence: true, 
    length: { maximum: 50 }

  VALID_EMAIL_REGEXP = %r{(?i:\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z)}
  validates :email, 
    presence: true, 
    uniqueness: { case_sensitive: false },
    format: { with: VALID_EMAIL_REGEXP }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save do |user| 
    user.name = user.name.split.map(&:capitalize).join(' ')
    self.email.downcase!
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

  private

    def create_user_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end
