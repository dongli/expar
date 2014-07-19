class CreateFigures < ActiveRecord::Migration
  def change
    create_table :figures do |t|
      t.belongs_to :diag
      t.string :title
      t.attachment :file
      t.text :comment
      t.timestamps
    end
  end
end
