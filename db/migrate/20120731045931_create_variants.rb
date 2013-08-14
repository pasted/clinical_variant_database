class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :name
      t.string :reference
      t.string :alternative

      t.timestamps
    end
  end
end
