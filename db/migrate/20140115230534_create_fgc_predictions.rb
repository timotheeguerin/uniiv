class CreateFgcPredictions < ActiveRecord::Migration
  def change
    create_table :fgc_predictions do |t|
      t.references :user
      t.references :course

      t.timestamps
    end
  end
end
