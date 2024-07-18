class CreateSupportAgencyAdviceAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :support_agency_advice_areas do |t|
      t.references :support_agency, null: false, foreign_key: false
      t.references :advice_area, null: false, foreign_key: false

      t.timestamps
    end
  end
end
