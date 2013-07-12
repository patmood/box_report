get '/' do
  erb :index
end

get '/report' do
  authed?
  @user = User.find(session[:user_id])
  erb :report
end
