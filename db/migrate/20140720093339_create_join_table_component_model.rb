class CreateJoinTableComponentModel < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_join_table :components, :models do |t|
      t.column :component_id, :uuid
      t.column :model_id, :uuid
      # t.index [:component_id, :model_id]
      # t.index [:model_id, :component_id]
    end
  end
end
