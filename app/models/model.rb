class Model < ActiveRecord::Base
  has_and_belongs_to_many :components
  has_many :experiments

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :contact, presence: true
  validates :email, presence: true
end
