class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.boolean :completed, default: false
      t.datetime :due_date
      t.datetime :completion_date

      t.references :category
      t.references :user
      
      t.timestamps
    end
  end
end
