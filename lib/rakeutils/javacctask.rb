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

# Implements programmatic control of the JavaCC application.

class JavaCCTask < CLApp
include FileUtils

  APP_PATH = "M:/javacc/bin/javacc.bat"

  # Constructor
  def initialize()
    super( APP_PATH )   # Call parent constructor.

    @lookAhead = ""
    @static = ""
    @outputDir = ""
  end # initialize

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
    @lookAhead = lookAhead.to_s
  end

  # Set the output directory.
  # pathname:: string; path of output directory. Default = current directory.
  def outputDir(pathname)
    @outputDir = pathname
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
    cmdLine = cmdLine + " -LOOKAHEAD:#{@lookAhead}" unless @lookAhead.empty?
    cmdLine = cmdLine + " -OUTPUT_DIRECTORY:#{@outputDir}" unless @outputDir.empty?

    cmdLine = cmdLine + " #{grammar}"

    begin
        execute( cmdLine, false )
    rescue
        puts "!!! Errors occured during parsing of JavaCC grammar."
    end
  end # generate
end # class JavaCCTask
