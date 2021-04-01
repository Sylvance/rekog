class CreateImageQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :image_queries do |t|
      t.string :name
      t.references :person, null: false, foreign_key: true
      t.boolean :is_match
      t.float :percentage_match

      t.timestamps
    end
  end
end
