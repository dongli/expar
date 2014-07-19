class Figure < ActiveRecord::Base
  belongs_to :diag, inverse_of: :figures

  has_attached_file :file, :styles => { :small => '800x800>' },
    url: '/assets/figures/:id/:style/:basename.:extension',
    path: ':rails_root/public/assets/figures/:id/:style/:basename.:extension'

  validates :title, uniqueness: { scope: :diag }
  validates_attachment_presence :file
  validates_attachment_content_type :file,
    :content_type => ['image/jpeg', 'image/png', 'application/pdf']
end
