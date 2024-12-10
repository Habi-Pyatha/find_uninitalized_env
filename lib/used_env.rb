class UsedEnv

  
  def self.find_ruby_files
    # Dir.glob("./**/**/**/*.{rb,html,erb}")
    Dir["./**/*.{rb,html,erb}"]
  end

  def self.find_env_variables
    file_names = find_ruby_files
    env_vars = []
    
    file_names.each do |file|
      File.foreach(file).with_index do |line,line_num|
        next if line.strip.empty? || line.strip.start_with?('#')

        # matches =line.scan(/ENV\["(.*?)"\]|ENV\['(.*?)'\]|ENV\.fetch\(["'](.*?)["']\)/)
        matches = line.scan(/ENV\[["'](.*?)["']\]|ENV\.fetch\(["'](.*?)["']\)/)
        
        matches.flatten.compact.each do |env_var|
          
              env_vars << { env_variable: env_var, file: file, line: line_num + 1 }
            
         
        end
      end
    end
    env_vars
  end

  def self.find_uninitialized_env
    
    # used_env=find_env_variables
    # puts used_env
    # require "env_list"
    # dotEnv = Env_list.load_env.uniq
    # dotEnv.each do |comp|
    #   puts comp
    # end
    # puts ENV["Email"]
    # puts dotEnv
    file_names = find_ruby_files
    unused_vars=[]
    require "env_list"
     dotEnv = Env_list.load_env
     env_vars=find_env_variables
     env_vars.each do |env_var|
       unless dotEnv.include?(env_var[:env_variable])
          unused_vars << env_var
       end
     end
    # file_names.each do |file|
    #   File.foreach(file).with_index do |line,line_num|
    #     next if line.strip.empty? || line.strip.start_with?('#')

    #     # matches =line.scan(/ENV\["(.*?)"\]|ENV\['(.*?)'\]|ENV\.fetch\(["'](.*?)["']\)/)
    #     matches = line.scan(/ENV\[["'](.*?)["']\]|ENV\.fetch\(["'](.*?)["']\)/)
        
    #     matches.flatten.compact.each do |env_var|
    #       unless dotEnv.include?(env_var)
    #           env_vars << { env_variable: env_var, file: file, line: line_num + 1 }
            
    #       end
    #     end
    #   end
    # end
    unused_vars
  end

end

puts UsedEnv.find_env_variables
puts UsedEnv.find_uninitialized_env
puts ENV["Email"].empty?
puts ENV.has_key?("Email")