require "active_support/all"
require "git"
require "yaml"

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

    # Successful exit
    exit 0
  end
  
end

