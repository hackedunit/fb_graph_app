class OauthController < ApplicationController
  
  def start
    redirect_to client.web_server.authorize_url(
      :redirect_uri => oauth_callback_url,
      :scope => 'publish_stream, offline_access, email'
    )
  end

  def callback
    access_token = client.web_server.access_token(
      params[:code], :redirect_uri => oauth_callback_url
    )
    user_json = JSON.parse(access_token.get('/me'))    
    user = User.find_by_facebook_id(user_json["id"])
    
    if user.blank?
      user = User.new(:name => user_json["name"], :email => user_json["email"], :facebook_id => user_json["id"], :fb_access_token => access_token.token)
      if user.save
        flash[:notice] = "Successfully created new user #{user.name}"
      else
        flash[:error] = "There was an error creating user"
      end
    else
      flash[:notice] = "Successfully logged in as user #{user.name}"
    end
    
    session[:user_id] = user.id
    redirect_to_target_or_default root_path
  end

  protected

  def client
    @client ||= OAuth2::Client.new(
      APP_CONFIG[:fb_app_id], APP_CONFIG[:fb_app_secret], :site => 'https://graph.facebook.com'
    )
  end
  
end
