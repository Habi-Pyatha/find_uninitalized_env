class UsedEnv
  def self.find_ruby_files
    Dir.glob("./**/**/*.rb")
  end

  def self.find_env_variables
    file_names=find_ruby_files
    env_vars=[]
    file_names.each do |file|
      File.foreach(file).with_index do |line,index|
        next if line.strip.empty? || line.strip.start_with?("#")
        matches = line.scan(/ENV\[["'](.*?)["']\]|ENV\.fetch\(["'](.*?)["']\)/)
        matches.flatten.compact.each do |env_var|
          env_vars << {env_var: env_var, file: file, line: index +1}
        end
      end
    end
    return env_vars
  end
end

puts UsedEnv.find_env_variables