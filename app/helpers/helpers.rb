  
  # def calculate_size
  #   Folder.where(parent: temp.parent).each do |folder|
  #     p "WORKING IN: #{folder.is_dir} #{folder.path}"
  #   end
  # end

  def calculate_size(parent)
    total = 0
    Folder.where(parent: parent+1).each do |folder|
      total += folder.bytes
    end
    Folder.where(parent: parent).each do |folder|
      folder.update_attributes()
    end

    total
  end
