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

  # Constructor
  def initialize()
      super( find_app )   # Call parent constructor.

    app_path = find_app
    if app_path.nil? or app_path.empty? or !File.exist?(app_path)
      if Ktutils::OS.windows?
        # ISCC_EXE_PATH env var should point to the executable.
        # ie. "M:/Inno5.3.5/ISCC.exe"
        msg = "ISCC_EXE_PATH environment variable is not configured correctly "
        msg += "or Inno Setup is not installed."
        msg += "\nISCC not found"
        raise msg
      else
        msg = "iscc command not found. "
        msg += "See <https://katastrophos.net/andre/blog/2009/03/16/setting-up-the-inno-setup-compiler-on-debian/> "
        msg += "for instructions on installing Inno Setup in linux."
        msg += "\niscc not found"
        raise msg
      end
    end

  end # initialize

  def find_app
    if Ktutils::OS.windows?
      app_path = ENV["ISCC_EXE_PATH"]
    else
      app_path = `which iscc`.chomp
    end
  end

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
      execute( cmd_line, false )
    rescue Exception => e
      puts "!!! Errors occured during compilation of setup script."
      puts e.message
    end
  end # compile
end # class InnoTask
