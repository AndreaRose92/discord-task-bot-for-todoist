class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :external_id
      t.string :name
      t.integer :comment_count
      t.string :color
      t.boolean :is_shared
      t.integer :order
      t.boolean :is_favorite
      t.boolean :is_inbox_project
      t.boolean :is_team_inbox
      t.string :view_style
      t.string :url
      t.integer :parent_id
      t.timestamps
    end
  end
end
