##############################################################################
# File:: ocraTask.rb
# Purpose:: Run OCRA against a ruby source tree
#
# Author::    Jeff McAffee 10/29/2009
# Copyright:: Copyright (c) 2009 kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################


=begin
ocra.rb command line:
ruby.exe -S ocra.rb SCRIPT
=end

require 'ktutils/os'

require_relative 'clapp'

# Implements programmatic control of the OCRA application.
class OcraTask < CLApp
include FileUtils

  if Ktutils::OS.windows?
    APP_PATH = "N:/Ruby/bin/ruby.exe"
  else
    APP_PATH = `which ruby`.chomp
  end

  # Constructor
  def initialize()
    super( APP_PATH )   # Call parent constructor.
  end # initialize

  # Generate executable application from a ruby script.Compile setup script.
  # script:: Script to be compiled
  def compile(script)
    puts "Compiling script: #{script}"

    cmdLine = "ocra.rb --windows #{script}"

    begin
      execute( cmdLine, false )
    rescue
      puts "!!! Errors occured during compilation of setup script."
    end
  end # compile
end # class OcraTask
