class CreateExperiments < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :experiments, id: :uuid do |t|
      t.uuid :model_id
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
