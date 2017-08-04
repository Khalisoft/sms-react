class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :kind
      t.string :name
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
