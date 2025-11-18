class CreateCats < ActiveRecord::Migration[7.2]
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.integer :age
      t.string :gender
      t.string :breed
      t.text :personality
      t.text :helth
      t.string :status, default: "募集中"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
