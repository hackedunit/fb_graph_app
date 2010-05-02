class UsersController < ApplicationController
  
  before_filter :login_required
  
  def post_to_fb
    @user = current_user
    unless @user.fb_page_id.blank?
      get_fb_page = Facebook::Graph.new("#{@user.fb_page_id}",'get') do |config| end
      get_fb_page_feed = Facebook::Graph.new("#{@user.fb_page_id}/feed",'get') do |config| end
      @fb_page = get_fb_page.result_body
      @fb_page_feed = get_fb_page_feed.result_body
    end
  end
  
  def post_to_my_feed
    Facebook::Graph.new('me/feed','post') do |config|
      config.add_form_data('access_token', current_user.fb_access_token)
      config.add_form_data('message', params[:content])
      config.add_form_data('link', params[:link])
    end
    flash[:notice] = "Successfully posted to feed"
    redirect_to post_to_fb_users_path
  end
  
  def post_to_my_page
    Facebook::Graph.new("#{current_user.fb_page_id}/feed",'post') do |config|
      config.add_form_data('access_token', current_user.fb_access_token)
      config.add_form_data('message', params[:content])
      config.add_form_data('link', params[:link])
    end
    flash[:notice] = "Successfully posted to page"
    redirect_to post_to_fb_users_path
  end
  
  def update
    @user = current_user
    if @user.update_attributes params[:user]
      flash[:notice] = "Successfully saved"
      redirect_to post_to_fb_users_path
    else
      flash.now[:error] = "There was an error"
      render :action => "post_to_fb"
    end
  end
  
end
