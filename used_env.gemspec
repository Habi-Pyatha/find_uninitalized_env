Gem::Specification.new do |s|
  s.name        = "used_env"
  s.version     = "0.0.10"
  s.executables = ["used_env"]
  s.summary     = "Finds the ENV variables used in Ruby files."
  s.description = <<~DESC
    A gem to list all the environment variables used in a Ruby project.

    Example usage:
      results = UsedEnv.find_env_variables

      results.each do |entry|
        puts "ENV_Variable: \#{entry[:variable]} | File_path: \#{entry[:file]} | Line: \#{entry[:line]}"
      end
  DESC
  s.authors = ["Habi Pyatha"]
  s.files = ["lib/used_env.rb","bin/used_env","lib/env_list.rb"]
  # s.files     = Dir.glob("{lib,bin}/**/*")
end
