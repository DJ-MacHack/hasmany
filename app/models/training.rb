class Training < ApplicationRecord
  belongs_to :worker, optional: true
  belongs_to :line, optional: true
  has_many :trainingslines
  has_many :trainingsmemberships
  has_many :workers, through: :trainingsmemberships
  has_many :lines, through: :trainingslines
  accepts_nested_attributes_for :worker
  accepts_nested_attributes_for :line
  accepts_nested_attributes_for :trainingsmemberships
  validates :name, presence: true, length: { minimum: 1 }
  mount_uploader :attachement
end