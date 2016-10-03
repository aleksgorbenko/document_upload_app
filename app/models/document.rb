class Document < ApplicationRecord
  validates :title, presence: true, length: { within: 5..40 }
  validates :file, presence: true
  belongs_to :user
  mount_uploader :file, FileUploader
end
