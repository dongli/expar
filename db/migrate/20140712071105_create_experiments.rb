class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :title
      t.string :model
      t.string :date
      t.string :author
      t.string :email
      t.text :comment
      t.timestamps
    end
  end
end
