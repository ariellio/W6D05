# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  session_token   :string
#
class User < ApplicationRecord
  validates :username, :password_digest, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialize :ensure_session_token

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(plain_password)#abc123 -> hashing as pass_digest 
    self.password_digest = BCrypt::Password.create(plain_password)
    @password = plain_password
  end

  def password
    @password
  end

  def check_password?(type_in_password)
    password_banana = BCrypt::Password.new(self.password_digest)
    password_banana.is_password?(type_in_password)
  end

  def self.find_by_credentials(username, password)
      user = User.find_by(username: username)
        if user && user.check_password?(password) 
            user 
        else
            nil 
        end
  end
end
