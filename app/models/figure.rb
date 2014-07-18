class Figure < ActiveRecord::Base
  belongs_to :experiment, inverse_of: :figures

  has_attached_file :file, :styles => { :small => '800x800>' },
    url: '/assets/figures/:id/:style/:basename.:extension',
    path: ':rails_root/public/assets/figures/:id/:style/:basename.:extension'

  validates :title, uniqueness: { scope: :experiment }
  validates_attachment_presence :file
  validates_attachment_content_type :file,
    :content_type => ['image/jpeg', 'image/png', 'application/pdf']
  #validates :comment, presence: true, length: {
  #  minimum: 1,
  #  tokenizer: lambda { |str| str.scan(/\w+/) },
  #  too_short: "must have at least %{count} words"
  #}
end
