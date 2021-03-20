class CreateLocationsPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :locations_people do |t|
      t.belongs_to :person
      t.belongs_to :location

      t.timestamps
    end
  end
end
