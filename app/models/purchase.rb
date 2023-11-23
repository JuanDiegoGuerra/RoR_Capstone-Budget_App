class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60, too_long: '%<count>s characters is the maximum allowed' }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end