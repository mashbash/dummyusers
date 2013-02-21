require 'digest/md5'

enable :sessions
get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  usr = User.find_by_email params[:email]
  # if usr is nil here, that means the account doesn't
  # exist -- print error message and encourage user to register?

  if usr.password == params[:password]
    session[:secret_url] = usr.secret_url
    session[:message] = "Login Successful"
    redirect "/user/#{usr.secret_url}"
  else
    session[:message] = "Login failed"
    redirect '/'
  end
end

get '/logout' do
  # clean out sessions hash
  session.delete("secret_url")
  session[:message] = "Logout complete"
  redirect '/'
end

get '/user/:secret_url' do
  @usr = User.find_by_secret_url(params[:secret_url])
  if @usr.secret_url == session[:secret_url]
    erb :secret_page
  else
    session[:message] = "Unauthorized access!!!! Please Sign in."
    session.delete("secret_url")
    redirect '/'  
  end  
end

post '/user' do
  secret_url = Digest::MD5.hexdigest("#{params[:email]}#{Time.now}")
  usr = User.new(first_name: params[:first_name],
                 last_name: params[:last_name],
                 email: params[:email],
                 password: params[:password],
                 secret_url: secret_url)
  if usr.save
    session[:message] = "Account successfully created."
    redirect "/user/#{usr.secret_url}"
  else
    # error message
    session[:message] = "Incomplete fields"
  end
end
