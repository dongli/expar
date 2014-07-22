class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.belongs_to :model
      t.string :title
      t.string :component_versions
      t.string :component_resolutions
      t.string :date
      t.string :contact
      t.string :email
      t.integer :created_by_user
      t.text :comment
      t.timestamps
    end
  end
end
