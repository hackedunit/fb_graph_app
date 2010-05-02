ActionController::Routing::Routes.draw do |map|

  map.resources :users, :collection => { :post_to_fb => :get, :post_to_my_feed => :post, :post_to_my_page => :post }
  
  map.oauth_authorize '/oauth/start', :controller => 'oauth', :action => 'start'
  map.oauth_callback '/oauth/callback', :controller => 'oauth', :action => 'callback'

  map.root :controller => "oauth"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
