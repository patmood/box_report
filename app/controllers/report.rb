get '/fetch_data' do
  authed?
  @client = get_client
  @user = User.find(session[:user_id])
  @data_summary = []

  def get_size(client,path,parent)
    item = client.metadata(path)
    current_folder = @user.folders.find_or_initialize_by(path: item['path'])
    current_folder.update_attributes(path: item['path'], is_dir: item['is_dir'], bytes: item['bytes'], parent: parent)

    total_size = 0

    item['contents'].each do |content|
      if content['is_dir']
        total_size += get_size(client,content['path'], current_folder.id)
      else
        total_size += content['bytes']
        new_file = @user.folders.find_or_initialize_by(path: content['path'])
        new_file.update_attributes(path: content['path'], is_dir: content['is_dir'], bytes: content['bytes'], parent: parent)
      end
      total_size
    end

    current_folder.update_attributes(bytes: item['bytes']+total_size)

    total_size
  end

  get_size(@client,'/OpenVPN',0)

  p @client.metadata('/OpenVPN')

  redirect '/report'
end

