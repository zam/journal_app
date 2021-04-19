class Category < ApplicationRecord
  
  validates :name, presence: true
  validates :name, length: { in: 1..50 }
  validates :description, length: { maximum: 200 }
  validates_uniqueness_of :name, scope: :user_id
  
  belongs_to :user
  has_many :tasks, :dependent => :destroy

end
