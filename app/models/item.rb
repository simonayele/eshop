class Item < ApplicationRecord
  validates :title, presence: true
 

  mount_uploaders :image, ImageUploader
  belongs_to :user
end
