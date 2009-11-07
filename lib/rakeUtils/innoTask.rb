######################################################################################
#
# innoTask.rb
#
# Jeff McAffee   10/30/08
#
# Purpose: Implements InnoSetup5 functionality for rake usage
#
######################################################################################

=begin
InnoSetup command line:
m:\Inno5.3.5\ISCC.exe /OOutPutDir /FOutputBaseFileName SCRIPT
=end

# Implements programmatic control of the InnoSetup5 application.

class InnoTask < CLApp
include FileUtils

    APP_PATH = "M:/Inno5.3.5/ISCC.exe"

  
    # Constructor
    def initialize()
        super( APP_PATH )   # Call parent constructor.
    end # initialize


    # Compile setup script.
    # destDir:: destination directory
    # filename:: Output base filename
    # script:: Script to be compiled
    def compile(destDir, filename, script)
        destDir = File.expand_path( destDir )
        script = File.expand_path( script )
        
        destDir = windowizePath( destDir )      # Make sure the paths are in windows format for the compiler.
        script = windowizePath( script )
        
        puts "destDir: #{destDir}"
        puts "filename: #{filename}"
        puts "script: #{script}"
        
        cmdLine = "/O#{destDir} /F#{filename} #{script}"

        begin
            execute( cmdLine, false )
        rescue
            puts "!!! Errors occured during compilation of setup script."
        end
    end # compile


end # class InnoTask
