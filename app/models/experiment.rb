class Experiment < ActiveRecord::Base
  has_many :diags, dependent: :destroy
  belongs_to :model

  validates :title, presence: true
  validates :title, uniqueness: true, :on => :create
  validates :date, presence: true
  validates :contact, presence: true
  validates :email, presence: true
  validates :comment, presence: true

  attr_accessor :atmosphere_version, :atmosphere_resolution
  attr_accessor :land_version, :land_resolution
end
