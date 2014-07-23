class Figure < ActiveRecord::Base
  belongs_to :diag

  has_attached_file :file, styles: { small: [ '800x800>', :png ], medium: [ '1200x1200', :png ] },
    url: '/assets/figures/:id/:style/:basename.:extension',
    path: ':rails_root/public/assets/figures/:id/:style/:basename.:extension'

  validates :title, uniqueness: { scope: :diag }
  validates_attachment_presence :file
  validates_attachment_content_type :file,
    :content_type => ['image/jpeg', 'image/png', 'application/pdf']
end
