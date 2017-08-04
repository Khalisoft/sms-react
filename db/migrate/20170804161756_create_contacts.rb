class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :phone
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
