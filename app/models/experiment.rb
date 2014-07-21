class Experiment < ActiveRecord::Base
  has_many :diags, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true, :on => :create
  validates :date, presence: true
  validates :contact, presence: true
  validates :email, presence: true
  validates :comment, presence: true
end
