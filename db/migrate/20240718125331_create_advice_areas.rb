class CreateAdviceAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :advice_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
