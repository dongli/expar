class CreateDiags < ActiveRecord::Migration
  def change
    create_table :diags do |t|
      t.belongs_to :experiment
      t.integer :category
      t.string :contact
      t.string :email
      t.integer :created_by_user
      t.string :comment
      t.timestamps
    end
  end
end
