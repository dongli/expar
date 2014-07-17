class User < ActiveRecord::Base
  enum role: [ :admin, :author, :guest ]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_defaults

  def set_defaults
    if self.id == 1
      # set the first user as admin
      self.role = :admin
    else
      self.role ||= :guest
    end
  end
end
