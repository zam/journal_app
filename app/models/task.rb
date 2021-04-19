class Task < ApplicationRecord

  validates :name, :due_date, presence:true
  validates :name, length: { in: 1..40 }
  validates :description, length: { maximum: 200 }

  belongs_to :category
  belongs_to :user
  
end
