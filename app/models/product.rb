class Product < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :price, presence: true
  validates :count, presence: true
end 