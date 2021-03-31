class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :email
      t.string :residence

      t.timestamps
    end
  end
end
