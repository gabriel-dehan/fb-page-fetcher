class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :fb_uid,  null: false
      t.string  :name,    null: false
      t.string  :category
      t.string  :picture
      t.integer :likes,   null: false

      t.timestamps
    end
    add_index :pages, :fb_uid, unique: true
  end
end
