class UsedEnv
  
  # puts dotEnv.class
  def self.find_ruby_files
    # Dir.glob("./**/**/**/*.{rb,html,erb}")
    Dir["./**/*.{rb,html,erb}"]
  end

  def self.find_env_variables
    file_names = find_ruby_files
    env_vars = []
    require "env_list"
     dotEnv = Env_list.load_env.uniq
    file_names.each do |file|
      File.foreach(file).with_index do |line,line_num|
        next if line.strip.empty? || line.strip.start_with?('#')

        # matches =line.scan(/ENV\["(.*?)"\]|ENV\['(.*?)'\]|ENV\.fetch\(["'](.*?)["']\)/)
        matches = line.scan(/ENV\[["'](.*?)["']\]|ENV\.fetch\(["'](.*?)["']\)/)
        
        matches.flatten.compact.each do |env_var|
          unless dotEnv.include?(env_var)
              env_vars << { env_variable: env_var, file: file, line: line_num + 1 }
            
          end
        end
      end
    end
    env_vars
  end

  def self.find_uninitialized_env
    
    used_env=find_env_variables
    puts used_env
    # require "env_list"
    # dotEnv = Env_list.load_env.uniq
    # dotEnv.each do |comp|
    #   puts comp
    # end
    # puts ENV["Email"]
    # puts dotEnv
  end

end

UsedEnv.find_uninitialized_env
