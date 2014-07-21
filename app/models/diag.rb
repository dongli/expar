class Diag < ActiveRecord::Base
  belongs_to :experiment
  has_many :figures, dependent: :destroy

  enum category: [ :climo, :mjo ]

  validates :category, uniqueness: { scope: :experiment }, :on => :create
  validates :contact, presence: true
  validates :email, presence: true
end
