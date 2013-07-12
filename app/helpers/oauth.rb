def get_client
  db_session = DropboxSession.deserialize(session[:authorized_db_session])
  client = DropboxClient.new(db_session,ACCESS_TYPE)
end

def authed?
  redirect '/signin' unless session[:authorized_db_session]
  dropbox_session = DropboxSession.deserialize(session[:authorized_db_session])
  redirect '/signin' unless dropbox_session.authorized?
  user = User.find_by_db_session(session[:authorized_db_session])
  redirect '/signin' unless user
  session[:user_id] = user.id
end
