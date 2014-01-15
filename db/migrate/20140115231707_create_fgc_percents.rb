class CreateFgcPercents < ActiveRecord::Migration
  def change
    create_table :fgc_percents do |t|
      t.float :value
      t.references :group, index: true
      t.references :scheme, index: true

      t.timestamps
    end
  end
end
