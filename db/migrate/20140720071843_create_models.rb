class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :title
      t.string :contact
      t.string :email
      t.string :comment
      t.integer :created_by_user
      t.timestamps
    end
  end
end
