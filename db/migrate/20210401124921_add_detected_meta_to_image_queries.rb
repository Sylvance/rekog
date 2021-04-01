class AddDetectedMetaToImageQueries < ActiveRecord::Migration[6.1]
  def change
    add_column :image_queries, :detected_meta, :text
  end
end
