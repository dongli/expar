class CreateFigures < ActiveRecord::Migration
    def change
        create_table :figures do |t|
            t.integer :experiment_id
            t.string :title
            t.attachment :file
            t.text :comment
            t.timestamps
        end
    end
end
