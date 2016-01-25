class Micropost < ActiveRecord::Base
  has_many :microposts
  belongs_to :user
  validates :user_id, presence: true
  validates :contents, presence: true, length: {maximum: 140}
end
