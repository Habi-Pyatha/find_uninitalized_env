class Env_list
  def self.load_env
    keys=[]
    File.foreach(".env") do |line|
      next if line.strip.empty? || line.start_with?('#')

      key,value=line.strip.split("=",2)
      ENV[key]=value if key && value
      
      keys.push(key)
    end
  #  display key value pair
    # keys.each do |k|
    #   # puts "#{k}"
    #   # +ENV[k]
    # end
    return keys
  end
  
end
# Env_list.load_env('.env')


# Env_list.load_env



