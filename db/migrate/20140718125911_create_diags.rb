class CreateDiags < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :diags, id: :uuid do |t|
      t.uuid :experiment_id
      t.integer :category
      t.string :contact
      t.string :email
      t.integer :created_by_user
      t.string :comment
      t.timestamps
    end
  end
end
