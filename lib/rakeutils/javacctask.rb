##############################################################################
# File:: javaccTask.rb
# Purpose:: Run JavaCC against a grammar file to generate java code.
#
# Author::    Jeff McAffee 02/26/2010
# Copyright:: Copyright (c) 2010 kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################


=begin
javacc.bat command line:
javacc [OPTIONS] GRAMMAR_FILE
=end
require 'ktutils/os'
require 'fileutils'

require_relative 'clapp'

# Implements programmatic control of the JavaCC application.

class JavaCCTask < CLApp
include FileUtils

  # Constructor
  def initialize()
    super( find_app )   # Call parent constructor.

    app_path = find_app
    if app_path.nil? or app_path.empty? or !File.exist?(app_path)
      if Ktutils::OS.windows?
        msg = "JAVACC_HOME environment variable is not configured correctly "
        msg += "or JavaCC is not installed."
        msg += "\njavacc.bat not found"
        raise msg
      else
        raise "javacc not found"
      end
    end

    @look_ahead = ""
    @static = ""
    @output_dir = ""
  end # initialize

  def find_app
    if Ktutils::OS.windows?
      app_home = ENV["JAVACC_HOME"]
      unless app_home.nil? or app_home.empty?
        app_path = File.join(app_home, "bin", "javacc.bat")
      end
    else
      app_path = `which javacc`.chomp
    end
  end

  # Set the static class generation flag.
  # true_or_false:: string; value (true or false). Default = true.
  def static(true_or_false)
    if (true_or_false != 'true' && true_or_false != 'false')
      puts "JJTreeTask Error: static must be string value ('true' or 'false')"
      return
    end
    @static = true_or_false
  end

  # Set the lookahead depth.
  # look_ahead:: string; depth of lookahead. Default = 1.
  def outputFile(look_ahead)
    @look_ahead = look_ahead.to_s
  end

  # Set the output directory.
  # pathname:: string; path of output directory. Default = current directory.
  def outputDir(pathname)
    @output_dir = pathname
  end

  # Generate java classes based on JavaCC grammar description file.
  # grammar:: grammar description file (.jj)
  def generateFrom(grammar)
    puts "Generating Java classes based on grammar file: #{grammar}"

    # Note: javacc help states that args can be supplied using either of
    #       2 forms:
    #         -OPTION=value
    #         -OPTION:value
    #
    #       So far, I get errors (and javacc doesn't recognize) options
    #       passed with '='.
    #
    #       Use form -OPTION: instead.
    options = []
    options << "-STATIC:#{@static}" unless @static.empty?
    options << "-LOOKAHEAD:#{@look_ahead}" unless @look_ahead.empty?
    options << "-OUTPUT_DIRECTORY:#{@output_dir}" unless @output_dir.empty?
    #cmd_line = ""
    #cmd_line = cmd_line + "-STATIC:#{@static}" unless @static.empty?
    #cmd_line = cmd_line + " -LOOKAHEAD:#{@look_ahead}" unless @look_ahead.empty?
    #cmd_line = cmd_line + " -OUTPUT_DIRECTORY:#{@output_dir}" unless @output_dir.empty?

    cmd_line = options.join(' ') + " #{grammar}"

    begin
        execute( cmd_line, false )
    rescue Exception => e
        puts "!!! Errors occured during parsing of JavaCC grammar."
        puts e.message
        #exit
    end
  end # generate
end # class JavaCCTask
