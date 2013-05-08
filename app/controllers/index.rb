get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  session.clear
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  @user = User.create(oauth_token: @access_token.token, :oauth_secret => @access_token.secret)
  @t_user = Twitter::Client.new(:oauth_token => @access_token.token, :oauth_token_secret => @access_token.secret)
  session[:id] = @user.id
  erb :index
end

post '/tweet' do
  user = User.find(session[:id])
  @t_user = Twitter::Client.new(:oauth_token => user.oauth_token, :oauth_token_secret => user.oauth_secret)
  @t_user.update(params[:tweet])
  erb :index
end
