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

require_relative 'clapp'
# Implements programmatic control of the Tex2Rtf application.

class Tex2Rtf < CLApp
include FileUtils

  #APP_PATH = "M:/Tex2RTF/tex2rtf.exe"

  # Constructor
  def initialize()
    super( find_app )
  end # initialize

  def find_app
    if Ktutils::OS.windows?
      app_home = ENV["TEX2RTF_HOME"]
      unless app_home.nil? or app_home.empty?
        app_path = File.join(app_home, "tex2rtf.exe")
      end
    else
      raise "cannot use tex2rtf on linux based systems"
    end
  end

  # Generate help files.
  # src_path:: Source file [.tex]. Path must use forward slashes.
  # dest_path:: Destination file. Path must use forward slashes.
  def generate_help_files(src_path, dest_path)
    src_dir = File.dirname( File.expand_path( src_path ) )
    src_file = File.basename( src_path )
    dest_path = File.expand_path( dest_path )
    dest_dir = File.dirname( dest_path )

    puts "src_dir: #{src_dir}"
    puts "src_path: #{src_path}"
    puts "dest_dir: #{dest_dir}"
    puts "dest_path: #{dest_path}"

    # Create the destination dir if it doesn't exits.
    if( !File.exists?( dest_dir ) )
      File.makedirs( dest_dir, true )
    end

    cmd_line = "#{src_file} #{dest_path} -checkcurleybraces -checksyntax -html"

    cur_dir = pwd
    cd( src_dir )
      begin
        execute( cmd_line, false )
      rescue
        # do nothing
      end
    cd( cur_dir )
  end # generate_help_files
end # class Tex2Rtf
