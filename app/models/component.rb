class Component < ActiveRecord::Base
  enum role: [ :atmosphere, :ocean, :land, :sea_ice, :land_ice, :coupler ]

  validates :title, presence: true
  validates :title, uniqueness: true, :on => :create
  validates :versions, presence: true
  validates :resolutions, presence: true 
  validates :contact, presence: true
  validates :email, presence: true
  validates :home_url, presence: true
end
