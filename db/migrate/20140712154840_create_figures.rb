class CreateFigures < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :figures, id: :uuid do |t|
      t.uuid :diag_id
      t.string :title
      t.attachment :file
      t.text :comment
      t.integer :created_by_user
      t.timestamps
    end
  end
end
