class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
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
