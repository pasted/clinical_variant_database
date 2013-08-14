class CreateChromosomes < ActiveRecord::Migration
  def change
    create_table :chromosomes do |t|
      t.string :name

      t.timestamps
    end
  end
end
