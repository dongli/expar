class Experiment < ActiveRecord::Base
  has_many :figures, dependent: :destroy, inverse_of: :experiment

  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
  validates :author, presence: true
  validates :mail, presence: true
  validates :comment, presence: true
end
