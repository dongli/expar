class CreateJoinTableComponentModel < ActiveRecord::Migration
  def change
    create_join_table :components, :models do |t|
      # t.index [:component_id, :model_id]
      # t.index [:model_id, :component_id]
    end
  end
end
