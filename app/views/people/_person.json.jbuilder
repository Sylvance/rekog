json.extract! person, :id, :firstname, :middlename, :lastname, :email, :phone, :residence, :meta, :created_at, :updated_at
json.url person_url(person, format: :json)
