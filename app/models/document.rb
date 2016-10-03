class Document < ApplicationRecord
  validates :title, presence: true, length: { within: 5..40 }
  belongs_to :user
  mount_uploader :file, FileUploader
end
