class CreateModels < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :models, id: :uuid do |t|
      t.string :title
      t.string :contact
      t.string :email
      t.string :comment
      t.integer :created_by_user
      t.timestamps
    end
  end
end
