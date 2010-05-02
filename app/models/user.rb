class User < ActiveRecord::Base
  
  validates_presence_of :name, :facebook_id, :fb_access_token
  validates_uniqueness_of :facebook_id
  validates_uniqueness_of :email, :allow_blank => true

end
