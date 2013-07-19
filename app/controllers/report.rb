get '/fetch_data' do
  authed?
  @client = get_client
  @user = User.find(session[:user_id])

  @user.get_size(@client,'/OpenVPN','/')

  redirect '/report'
end


get '/report' do
  authed?
  @user = User.find(session[:user_id])

  gon.free = @user.quota_total - (@user.quota_normal + @user.quota_shared)
  gon.normal = @user.quota_normal
  gon.shared = @user.quota_shared
  gon.percentage = (((@user.quota_normal + @user.quota_shared)/@user.quota_total.to_f)*100).round

  @folders = @user.folders.all
  @file_stats = @user.file_summary


  erb :report
end