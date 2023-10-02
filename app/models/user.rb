class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # simple validation
  validates :email, presence: true, length: { maximum: 255 }, format: VALID_EMAIL_REGEX, uniqueness: {case_sensitive: false}
end
