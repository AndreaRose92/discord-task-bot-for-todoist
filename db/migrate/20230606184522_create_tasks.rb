class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.string :external_id
      t.string :external_project_id
      t.string :section_id
      t.string :content
      t.string :description
      t.boolean :is_completed
      t.string :labels
      t.string :parent_id
      t.integer :order
      t.integer :priority
      t.string :url
      t.integer :comment_count
      t.timestamps
    end
  end
end
