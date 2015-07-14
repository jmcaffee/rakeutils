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

require_relative 'clapp'

# Implements programmatic control of the InnoSetup5 application.
class InnoTask < CLApp
include FileUtils

  APP_PATH = "M:/Inno5.3.5/ISCC.exe"

  # Constructor
  def initialize()
      super( APP_PATH )   # Call parent constructor.
  end # initialize

  # Compile setup script.
  #
  # dest_dir:: destination directory
  # filename:: Output base filename
  # script:: Script to be compiled
  def compile(dest_dir, filename, script)
    dest_dir = File.expand_path( dest_dir )
    script = File.expand_path( script )
    # Make sure the paths are in windows format for the compiler.
    dest_dir = windowize_path( dest_dir )
    script = windowize_path( script )

    puts "dest_dir: #{dest_dir}"
    puts "filename: #{filename}"
    puts "script: #{script}"

    begin
      execute( cmdLine, false )
    rescue
      puts "!!! Errors occured during compilation of setup script."
    end
  end # compile
end # class InnoTask
