class Worker < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  #validates :picture_size
  #scope :shift, -> (shift) { where shift: shift }
  #scope :line, -> (line) { where line: line }
  mount_uploader :picture, PictureUploader
  has_many :trainingsmemberships
  has_many :linememberships
  #has_one :workersshift
  #has_one :workerposition
  has_many :trainings, through: :trainingsmemberships
  has_many :lines, through: :linememberships
  has_one :shift#, through: :workersshift
  has_one :position#, through: :workerposition
#  accepts_nested_attributes_for :line
 # accepts_nested_attributes_for :training


  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end