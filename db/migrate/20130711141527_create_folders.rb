class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.text :path
      t.boolean :is_dir
      t.integer :bytes, :limit => 8
      t.text :parent
      t.integer :total_size, :limit => 8
      t.belongs_to :user
      t.timestamps

    end
  end
end
