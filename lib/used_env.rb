require 'optparse'

class UsedEnv
    Reset= "\e[0m"
    Green= "\e[32m"
    Red= "\e[31m"
    Yellow= "\e[33m"
    
  def self.find_files
    Dir["./**/*.{rb,html,erb,yml}"]
  end

  def self.find_env_variables
    env_vars = []
    
    find_files.each do |file|
      File.foreach(file).with_index do |line, line_num|
        next if line.strip.empty? || line.strip.start_with?('#')

        matches = line.scan(/ENV\[["'](.*?)["']\]|ENV\.fetch\(["'](.*?)["']\)/)
        matches.flatten.compact.each do |env_var|
          env_vars << { name: env_var, file: file, line: line_num + 1 }
        end
      end
    end

    env_vars.uniq
  end

  def self.categorize_env_variables
    categorized = { set: [], unset: [] }

    find_env_variables.each do |env|
      # if ENV[env[:name]]
      value = ENV[env[:name]]
      if value.nil? || value.empty?
        categorized[:unset] << env
      else
        categorized[:set] << env
      end
    end

    categorized
  end

  def self.display_envs(check)
    categorized = categorize_env_variables
    case check
    when 'valid'
      puts "Set ENV Variables:"
      categorized[:set].each { |env| puts "#{Green}#{env[:name]} -#{Yellow} #{env[:file]}:#{env[:line]} #{Reset} " }
    when 'invalid'
      puts "Unset ENV Variables:"
      categorized[:unset].each { |env| puts "#{Red}#{env[:name]} -#{Yellow} #{env[:file]}:#{env[:line]} #{Reset}" }
    else
      puts "Invalid option! Use 'valid' or 'invalid'."
    end
  end
end
# UsedEnv.display_envs("valid")
# UsedEnv.display_envs("invalid")

# puts UsedEnv.find_env_variables

