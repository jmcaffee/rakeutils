######################################################################################
#
# tex2rtf.rb
#
# Jeff McAffee   10/25/08
#
# Purpose: Implements tex2rtf functionality for rake usage
#
######################################################################################

=begin
tex2rtf command line:
m:\tex2rtf\tex2rtf.exe easydocs.tex easydocshelp.html -checkcurleybraces -checksyntax -html
=end

# Implements programmatic control of the Tex2Rtf application.

class Tex2Rtf < CLApp
include FileUtils

    APP_PATH = "M:/Tex2RTF/tex2rtf.exe"

  
    # Constructor
    def initialize()
        super( APP_PATH )   # Call parent constructor.
    end # initialize


    # Generate help files.
    # srcPath:: Source file [.tex]. Path must use forward slashes.
    # destPath:: Destination file. Path must use forward slashes.
    def generateHelpFiles(srcPath, destPath)
        srcDir = File.dirname( File.expand_path( srcPath ) )
        srcFile = File.basename( srcPath )
        destPath = File.expand_path( destPath )
        destDir = File.dirname( destPath )
        
        puts "srcDir: #{srcDir}"
        puts "srcPath: #{srcPath}"
        puts "destDir: #{destDir}"
        puts "destPath: #{destPath}"
        
        if( !File.exists?( destDir ) )          # Create the destination dir if it doesn't exits.
            File.makedirs( destDir, true )
        end
        
        cmdLine = "#{srcFile} #{destPath} -checkcurleybraces -checksyntax -html"

        curDir = pwd
        cd( srcDir )
            begin
                execute( cmdLine, false )
            rescue
                # do nothing
            end
        cd( curDir )
    end # generateHelpFiles


end # class Tex2Rtf
