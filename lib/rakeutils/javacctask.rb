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
        $stdout << "JAVACC_HOME environment variable is not configured correctly"
        $stdout << "or JavaCC is not installed."
        raise "javacc not found"
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
      javacc_home = ENV["JAVACC_HOME"]
      unless javacc_home.nil? or javacc_home.empty?
        app_path = File.join(javacc_home, "bin", "javacc.bat")
      end
    else
      app_path = `which javacc`.chomp
    end
  end

  # Set the static class generation flag.
  # trueOrFalse:: string; value (true or false). Default = true.
  def static(trueOrFalse)
    if (trueOrFalse != 'true' && trueOrFalse != 'false')
      puts "JJTreeTask Error: static must be string value ('true' or 'false')"
      return
    end
    @static = trueOrFalse
  end

  # Set the lookahead depth.
  # lookAhead:: string; depth of lookahead. Default = 1.
  def outputFile(lookAhead)
    @look_ahead = lookAhead.to_s
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
    cmdLine = ""
    cmdLine = cmdLine + "-STATIC:#{@static}" unless @static.empty?
    cmdLine = cmdLine + " -LOOKAHEAD:#{@look_ahead}" unless @look_ahead.empty?
    cmdLine = cmdLine + " -OUTPUT_DIRECTORY:#{@output_dir}" unless @output_dir.empty?

    cmdLine = cmdLine + " #{grammar}"

    begin
        execute( cmdLine, false )
    rescue
        puts "!!! Errors occured during parsing of JavaCC grammar."
    end
  end # generate
end # class JavaCCTask
