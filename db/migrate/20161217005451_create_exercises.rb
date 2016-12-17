class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :type
      t.string :sets
      t.string :reps
      t.text :description

      t.references :user, index: true, foreign_key: true
      t.references :workout, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
