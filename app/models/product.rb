class Product < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :price, presence: true
  validates :count, presence: true
  validates :user_id, presence: true
end 