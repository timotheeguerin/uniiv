class CreateFgcSchemes < ActiveRecord::Migration
  def change
    create_table :fgc_schemes do |t|
      t.references :prediction, index: true

      t.timestamps
    end
  end
end
