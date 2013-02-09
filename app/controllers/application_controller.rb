class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Login Facebook
  def login_facebook
    url = "https://www.facebook.com/dialog/oauth?client_id=#{getFacebookApiKey()}&amp;scope=email&amp;redirect_uri=#{getAppUrl()}login/facebook/callback"
    redirect_to url
  end
  
  # Login Facebook callback
  def login_facebook_callback
    require 'json'
    require 'rest_client'

    str_error = "There was an error trying to login to your Facebook account, please try again."

    if(params[:error] and params[:error] != '')
      flash[:error] = str_error
      redirect_to '/login'
    elsif(params[:code] and params[:code] != '')
      code = params[:code]
      url = "https://graph.facebook.com/oauth/access_token?client_id=#{getFacebookApiKey()}&amp;client_secret=#{getFacebookSecret()}&amp;redirect_uri=#{getAppUrl()}login/facebook/callback&amp;code=#{code}"

      r = RestClient.get url

      access_token = r.to_s.split("access_token=")[1]

      graph_url = "https://graph.facebook.com/me?access_token=#{access_token.uri_escape}"

      r = RestClient.get graph_url

      user = JSON.parse(r.to_s)

      doFacebookLogin(user)

      flash[:notice] = "You have logged in successfully."
      redirect_to '/items'
    else
      flash[:error] = str_error
      redirect_to '/login'
    end
  end
  
  def uri_escape
    require 'uri'
    str = URI.escape(self)
    return str
  end
  
end
