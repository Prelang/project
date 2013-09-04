require 'rubygems'
require 'rake'

# ------------------------------------------------
# TEST -------------------------------------------
# ------------------------------------------------
desc "Tests project gem"

task :test do
  sh "rspec spec/project_spec.rb"
end

# ------------------------------------------------
# UNINSTALL --------------------------------------
# ------------------------------------------------
desc "Uninstalls project gem and executables"

task :uninstall do
  # FIX: This does not work because it's not loading rvm and such.
  #sh "gem uninstall project --executables"
end

# ------------------------------------------------
# BUILD ------------------------------------------
# ------------------------------------------------
desc "Builds project gem"

task :build do
  sh "gem build project.gemspec"
end

# ------------------------------------------------
# INSTALL ----------------------------------------
# ------------------------------------------------
desc "Installs project gem"

task :install do
  sh "gem install project-0.0.1.gem"
end

desc "Uninstalls, Builds, and Installs project gem"

# ------------------------------------------------
# DEFAULT ----------------------------------------
# ------------------------------------------------
task :default => [:uninstall, :build, :install]
