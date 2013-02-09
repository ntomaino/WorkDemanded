class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :typeofjob_id
      t.string :zipcode

      t.timestamps
    end
  end
end
