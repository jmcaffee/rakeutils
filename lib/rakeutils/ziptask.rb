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

  # Constructor
  def initialize()
    super( find_app )

    app_path = find_app
    if app_path.nil? or app_path.empty?
      if Ktutils::OS.windows?
        raise "7Zip is not installed"
      else
        raise "7z not found"
      end
    end
  end # initialize

  def find_app
    if Ktutils::OS.windows?
      app_home = "7za.exe"
    else
      app_path = `which 7z`.chomp
    end
  end

  # Compress all files within a directory.
  # src_path:: Source directory. Path must use forward slashes.
  # archive_path:: Destination file. Path must use forward slashes.
  def compress(src_path, archive_path)
    src_dir = File.dirname( File.expand_path( src_path ) )
    src_file = File.basename( src_path )
    archive_path = File.expand_path( archive_path )
    dest_dir = File.dirname( archive_path )

    puts "src_dir: #{src_dir}"
    puts "src_path: #{src_path}"
    puts "dest_dir: #{dest_dir}"
    puts "archive_path: #{archive_path}"

    # Create the destination dir if it doesn't exist.
    if( !File.exists?( dest_dir ) )
      File.makedirs( dest_dir, true )
    end

    cmd_line = "-tzip u #{archive_path} #{src_path}"

    cur_dir = pwd
    cd( src_dir )
      begin
        execute( cmd_line, false )
      rescue
        # do nothing
      end
    cd( cur_dir )
  end # compress
end # class ZipTask
