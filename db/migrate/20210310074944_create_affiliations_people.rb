class CreateAffiliationsPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliations_people do |t|
      t.belongs_to :person
      t.belongs_to :affiliation

      t.timestamps
    end
  end
end
