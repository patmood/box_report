class User < ActiveRecord::Base
  has_many :folders

  def get_size(client,path,parent)
    item = client.metadata(path)


    current_folder = self.folders.find_or_initialize_by(path: item['path'])
    current_folder.update_attributes(path: item['path'], is_dir: item['is_dir'], bytes: item['bytes'], parent: parent)

    total_size = 0

    item['contents'].each do |content|
      if content['is_dir']
        total_size += get_size(client,content['path'], path)
      else
        total_size += content['bytes']
        new_file = self.folders.find_or_initialize_by(path: content['path'])
        new_file.update_attributes(path: content['path'], is_dir: content['is_dir'], bytes: content['bytes'], parent: path)
      end
    end
    current_folder.update_attributes(bytes: item['bytes']+total_size)

    total_size
  end


  def file_summary
  	max = ((self.folders.where(is_dir: false).order("bytes DESC").first.bytes)/1024.0/1024.0)
  	min = ((self.folders.where(is_dir: false).order("bytes ASC").first.bytes)/1024.0)
  	sum = 0
  	num_files = 0
  	self.folders.where(is_dir: false).each do |file|
  		sum += file.bytes
  		num_files += 1
  	end
  	mean = (sum/num_files.to_f)/1024.0/1024.0
  	file_stats = {max: max.round(2), min: min.round(2), mean: mean.round(2), sum: sum, num_files: num_files}
  	file_stats

  end

end
