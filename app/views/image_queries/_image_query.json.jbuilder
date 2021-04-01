json.extract! image_query, :id, :name, :person_id, :is_match, :percentage_match, :image, :matches_meta, :detected_meta, :created_at, :updated_at
json.url image_query_url(image_query, format: :json)
