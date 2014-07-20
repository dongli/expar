class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :title
      t.string :model
      t.string :date
      t.string :contact
      t.string :email
      t.integer :created_by_user
      t.text :comment
      t.timestamps
    end
  end
end
