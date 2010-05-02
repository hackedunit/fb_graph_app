class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :facebook_id
      t.text :fb_access_token
      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
  end
end
