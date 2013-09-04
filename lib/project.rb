require "active_support/all"
require "git"
require "yaml"
require "readline"
require "open3"

# ================================================
# MODULE->PROJECT ================================
# ================================================
module Project

  # ----------------------------------------------
  # ATTRIBUTES -----------------------------------
  # ----------------------------------------------
  mattr_accessor :commands, :configuration

  commands = []
  
  # ----------------------------------------------
  # UTILITY --------------------------------------
  # ----------------------------------------------
  #http://stackoverflow.com/questions/9620180/how-to-execute-interactive-shell-program-on-a-remote-host-from-ruby
  def self.execute_interactive(command)
    Open3.popen3(command) do |i, o, e, th|

      Thread.new {
        while !i.closed? do
          input =Readline.readline("", true).strip 
          i.puts input
        end
      }

      t_err = Thread.new {
        while !e.eof?  do
          putc e.readchar
        end
      }

      t_out = Thread.new {
        while !o.eof?  do
          putc o.readchar
        end
      }

      Process::waitpid(th.pid) rescue nil 
      # "rescue nil" is there in case process already ended.

      t_err.join
      t_out.join

    end
  end

  # ----------------------------------------------
  # COMMAND --------------------------------------
  # ----------------------------------------------
  def self.scripts
    Dir.glob "project/*"
  end

  # ----------------------------------------------
  # USAGE ----------------------------------------
  # ----------------------------------------------
  def self.usage
    puts "usage: project <action> [--dry-run]"
    return 1
  end

  # ----------------------------------------------
  # CONFIGURATION --------------------------------
  # ----------------------------------------------
  def self.load_configuration

    # Load the YAML file
    @configuration = YAML.load_file configuration_file_path

  end

  def self.configuration_file_path
    "Projectfile"
  end

  def self.environment_output
    env = {}

    # Set environment variables to use in scripts
    env["PROJECT_APPLICATION_PRODUCTION"] = @configuration["applications"]["production"]

    output = []

    env.each do |key, value|
      # FIX: Escape
      output << "#{key}=\"#{value}\""
    end

    output.join(" ")
  end

  # ----------------------------------------------
  # MESSAGING ------------------------------------
  # ----------------------------------------------
  def self.fatal(message, error_code=1)
    puts "fatal: #{message}"
    exit error_code
  end

  # ----------------------------------------------
  # APPLICATIONS ---------------------------------
  # ----------------------------------------------

  # ----------------------------------------------
  # HEROKU ---------------------------------------
  # ----------------------------------------------
  #def self.heroku_app_suffix(environment=:production)
    #"--app "@configuration["applications"][environment.to_s]
  #end

  # ----------------------------------------------
  # MAIN -----------------------------------------
  # ----------------------------------------------
  def self.main

    unless File.exist? configuration_file_path
      fatal "Projectfile not found."
    end

    load_configuration

    # Retrieve the line the script should execute
    puts [environment_output].concat(ARGV).join(" ")
    #execute_interactive "prompt foo"

    # Successful exit
    exit 0
  end
  
end

