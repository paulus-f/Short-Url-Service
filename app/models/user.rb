class User < ApplicationRecord
  has_secure_password

  has_many :short_urls

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
