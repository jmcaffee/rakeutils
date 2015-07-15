##############################################################################
# File:: jjTreeTask.rb
# Purpose:: Run JJTree (JavaCC) against a grammar file (.jjt) to generate
#           javacc grammar file (.jj).
#
# Author::    Jeff McAffee 02/26/2010
# Copyright:: Copyright (c) 2010 kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################


=begin
jjtree.bat command line:
jjtree [OPTIONS] GRAMMAR_FILE
=end

require 'ktutils/os'

require_relative 'clapp'

# Implements programmatic control of the JJTree application.

class JJTreeTask < CLApp
include FileUtils

  # Constructor
  def initialize()
    super( find_app )   # Call parent constructor.

    app_path = find_app
    if app_path.nil? or app_path.empty? or !File.exist?(app_path)
      if Ktutils::OS.windows?
        msg = "JAVACC_HOME environment variable is not configured correctly "
        msg += "or JavaCC is not installed."
        msg += "\njjtree.bat not found"
        raise msg
      else
        raise "jjtree not found"
      end
    end

    @static = ""
    @output_file = ""
    @output_dir = ""
  end # initialize

  def find_app
    if Ktutils::OS.windows?
      app_home = ENV["JAVACC_HOME"]
      unless app_home.nil? or app_home.empty?
        app_path = File.join(app_home, "bin", "jjtree.bat")
      end
    else
      app_path = `which jjtree`.chomp
    end
  end

  # Set the static class generation flag.
  # true_or_false:: string value (true or false). Default = true.
  def static(true_or_false)
    if (true_or_false != 'true' && true_or_false != 'false')
      puts "JJTreeTask Error: static must be string value ('true' or 'false')"
      return
    end
    @static = true_or_false.to_s
  end

  # Set the output filename.
  # filename:: string name of output file. Default = input filename with .jj suffix.
  def output_file(filename)
    @output_file = filename
  end

  # Set the output directory.
  # pathname:: string path of output directory. Default = current directory.
  def output_dir(pathname)
    @output_dir = pathname
  end

  # Generate javacc grammar file based on JJTree grammar description file.
  # grammar:: grammar description file (.jjt)
  def generate_from(grammar)
    puts "Generating JavaCC grammar from: #{grammar}"

    # Note: jjtree help states that args can be supplied using either of
    #       2 forms:
    #         -OPTION=value
    #         -OPTION:value
    #
    #       So far, I get errors (and jjtree doesn't recognize) options
    #       passed with '='.
    #
    #       Use form -OPTION: instead.
    options = []
    options << "-STATIC:#{@static}" unless @static.empty?
    options << "-OUTPUT_FILE:#{@output_file}" unless @output_file.empty?
    options << "-OUTPUT_DIRECTORY:#{@output_dir}" unless @output_dir.empty?

    cmd_line = options.join(' ') + " #{grammar}"

    begin
        execute( cmd_line, false )
    rescue Exception => e
        puts "!!! Errors occured during parsing of JJTree grammar."
        puts e.message
        exit
    end
  end # generate
end # class JJTreeTask
