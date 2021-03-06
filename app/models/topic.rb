class Topic < ActiveRecord::Base
  has_many :posts
  belongs_to :user

  validates :title, presence: :true, length: {maximum: 55}
  validates :image_url, presence: :true
end
