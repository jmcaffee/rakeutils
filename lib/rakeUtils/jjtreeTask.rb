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

# Implements programmatic control of the JJTree application.

class JJTreeTask < CLApp
include FileUtils

    APP_PATH = "M:/javacc/bin/jjtree.bat"

  
    # Constructor
    def initialize()
        super( APP_PATH )   # Call parent constructor.
        
        @static = ""
        @outputFile = ""
        @outputDir = ""
    end # initialize

    # Set the static class generation flag.
    # trueOrFalse:: string value (true or false). Default = true.
    def static(trueOrFalse)
      if (trueOrFalse != 'true' && trueOrFalse != 'false')
        puts "JJTreeTask Error: static must be string value ('true' or 'false')"
        return
      end
      @static = trueOrFalse.to_s
    end
    
    
    # Set the output filename.
    # filename:: string name of output file. Default = input filename with .jj suffix.
    def outputFile(filename)
      @outputFile = filename
    end
    
    
    # Set the output directory.
    # pathname:: string path of output directory. Default = current directory.
    def outputDir(pathname)
      @outputDir = pathname
    end
    
    
    # Generate javacc grammar file based on JJTree grammar description file.
    # grammar:: grammar description file (.jjt)
    def generateFrom(grammar)
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
        cmdLine = ""
        cmdLine = cmdLine + "-STATIC:#{@static}" unless @static.empty?
        cmdLine = cmdLine + " -OUTPUT_FILE:#{@outputFile}" unless @outputFile.empty?
        cmdLine = cmdLine + " -OUTPUT_DIRECTORY:#{@outputDir}" unless @outputDir.empty?
        
        cmdLine = cmdLine + " #{grammar}"

        begin
            execute( cmdLine, false )
        rescue
            puts "!!! Errors occured during parsing of JJTree grammar."
        end
    end # generate


end # class JJTreeTask