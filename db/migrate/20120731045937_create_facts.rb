class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :name
      t.string :number
      t.string :type
      t.string :description
      
      t.timestamps
    end
  end
end

