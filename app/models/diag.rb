class Diag < ActiveRecord::Base
  belongs_to :experiment, inverse_of: :diags
  has_many :figures, dependent: :destroy, inverse_of: :diag

  enum category: [ :climo, :mjo ]

  validates :category, uniqueness: { scope: :experiment }, :on => :create
  validates :author, presence: true
  validates :email, presence: true
end
