class CreateComponents < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :components, id: :uuid do |t|
      t.string :title
      t.integer :role
      t.string :versions
      t.string :resolutions
      t.string :contact
      t.string :email
      t.string :home_url
      t.integer :created_by_user
      t.text :comment
      t.timestamps
    end
  end
end
