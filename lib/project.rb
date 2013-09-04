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
    @configuration = YAML.load_file configuration_file_path
    puts @configuration
  end

  def self.configuration_file_path
    "Projectfile"
  end

  # ----------------------------------------------
  # MESSAGING ------------------------------------
  # ----------------------------------------------
  def self.fatal(message, error_code=1)
    puts "fatal: #{message}"
    exit error_code
  end

  # ----------------------------------------------
  # MAIN -----------------------------------------
  # ----------------------------------------------
  def self.main

    unless File.exist? configuration_file_path
      fatal "Projectfile not found."
    end

    load_configuration




    # Successful exit
    exit 0
  end
  
end

