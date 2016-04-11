class User < ActiveRecord::Base
  has_many :posts
  has_many :topics

  has_secure_password
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
end
