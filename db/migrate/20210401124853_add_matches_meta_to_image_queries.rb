class AddMatchesMetaToImageQueries < ActiveRecord::Migration[6.1]
  def change
    add_column :image_queries, :matches_meta, :text
  end
end
