get '/signin' do
  session.delete(:request_db_session)
  session.delete(:authorized_db_session)
  db_session = DropboxSession.new(APP_KEY, APP_SECRET)
  db_session.get_request_token

  session[:request_db_session] = db_session.serialize

  redirect db_session.get_authorize_url('http://localhost:9393/auth')
end

get '/signout' do
  session.delete(:request_db_session)
  session.delete(:authorized_db_session)
  session.delete(:user_id)
  redirect '/'
end

get '/auth' do
  ser = session[:request_db_session]
  db_session = DropboxSession.deserialize(ser)
  db_session.get_access_token # This is a destructive method
  session[:authorized_db_session] = db_session.serialize
  session.delete(:request_db_session)

  client = DropboxClient.new(db_session,ACCESS_TYPE)
  info = client.account_info()
  uid = info['uid']

  user = User.find_or_initialize_by(uid: uid)
  user.update_attributes( referral_link: info['referral_link'],
                          display_name: info['display_name'],
                          uid: info['uid'],
                          country: info['country'],
                          quota_shared: info['quota_info']['shared']/1024.0/1024.0,
                          quota_total: info['quota_info']['quota']/1024.0/1024.0,
                          quota_normal: info['quota_info']['normal']/1024.0/1024.0,
                          email: info['email'],
                          db_session: db_session.serialize
                          )
  session[:user_id] = user.id
  redirect '/report'
end
