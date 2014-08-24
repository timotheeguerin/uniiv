class CreateRichContents < ActiveRecord::Migration
  def change
    create_table :rich_contents do |t|
      t.text :text
      t.integer :format
      t.references :contentable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
