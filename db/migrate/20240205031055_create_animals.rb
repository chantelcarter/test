class CreateAnimals < ActiveRecord::Migration[7.1]
  def change
    create_table :animals do |t|
      t.string :common_name
      t.string :scientific_binomial

      t.timestamps
    end
  end
end
