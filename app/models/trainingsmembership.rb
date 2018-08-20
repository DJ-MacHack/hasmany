class Trainingsmembership < ApplicationRecord
  belongs_to :worker
  belongs_to :training
end
