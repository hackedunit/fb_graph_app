class AddFbPageIdUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_page_id, :string
  end

  def self.down
    remove_column :users, :fb_page_id
  end
end
