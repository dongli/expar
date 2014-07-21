class Component < ActiveRecord::Base
  has_and_belongs_to_many :models

  enum role: [ :atmosphere, :atmosphere_data,
               :ocean, :ocean_data,
               :land, :land_data,
               :sea_ice, :sea_ice_data,
               :land_ice, :land_ice_data,
               :coupler ]

  validates :title, presence: true
  validates :title, uniqueness: true, :on => :create
  validates :versions, presence: true
  validates :resolutions, presence: true 
  validates :contact, presence: true
  validates :email, presence: true
  validates :home_url, presence: true
end
