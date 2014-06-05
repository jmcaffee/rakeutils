######################################################################################
#
# zipTask.rb
#
# Jeff McAffee   10/30/08
#
# Purpose: Implements 7Zip functionality for rake usage
#
######################################################################################

=begin
tex2rtf command line:
m:\7Zip\7za.exe -tzip u ARCHIVENAME SOURCEDIR/FILENAME
=end

require_relative 'clapp'

# Implements programmatic control of the 7Zip application.

class ZipTask < CLApp
include FileUtils

    APP_PATH = "M:/7Zip/7za.exe"

  
    # Constructor
    def initialize()
        super( APP_PATH )   # Call parent constructor.
    end # initialize


    # Compress all files within a directory.
    # srcPath:: Source directory. Path must use forward slashes.
    # archivePath:: Destination file. Path must use forward slashes.
    def compress(srcPath, archivePath)
        srcDir = File.dirname( File.expand_path( srcPath ) )
        srcFile = File.basename( srcPath )
        archivePath = File.expand_path( archivePath )
        destDir = File.dirname( archivePath )
        
        puts "srcDir: #{srcDir}"
        puts "srcPath: #{srcPath}"
        puts "destDir: #{destDir}"
        puts "archivePath: #{archivePath}"
        
        if( !File.exists?( destDir ) )          # Create the destination dir if it doesn't exits.
            File.makedirs( destDir, true )
        end
        
        cmdLine = "-tzip u #{archivePath} #{srcPath}"

        curDir = pwd
        cd( srcDir )
            begin
                execute( cmdLine, false )
            rescue
                # do nothing
            end
        cd( curDir )
    end # compress


end # class ZipTask
