json.extract! person, :id, :firstname, :middlename, :lastname, :email, :residence, :image, :created_at, :updated_at
json.url person_url(person, format: :json)
