class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :referral_link
      t.string :display_name
      t.integer :uid, :limit => 8
      t.string :country
      t.integer :quota_shared, :limit => 8
      t.integer :quota_total, :limit => 8
      t.integer :quota_normal, :limit => 8
      t.string :email
      t.text :db_session
      t.timestamps
    end
  end
end
