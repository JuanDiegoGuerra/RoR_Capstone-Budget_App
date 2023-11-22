class User < ApplicationRecord
    has_many :groups
    has_many :purchases
  
    validates :name, presence: true, length: { maximum: 50, too_long: '%<count>s characters is the maximum allowed' }
  end