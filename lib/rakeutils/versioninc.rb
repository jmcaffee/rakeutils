######################################################################################
#
# versioninc.rb
#
# Jeff McAffee   11/02/08
#
# Purpose: Version Incrementer class. Used to increment version text in version files (*.ver)
#
######################################################################################

# Implements version incrementation support.

class VersionIncrementer
include FileUtils

  # If optional filename is supplied, load the version from the file.
  def initialize(filename=nil)
    @version = [0,0,0]
    read(filename) unless filename.nil?
  end # initialize

  def version()
    @version.join(".")
  end

  def inc_major( filename )
    read( filename )
    @version[0] = @version[0] + 1
    write( filename )
  end # inc_major

  def inc_minor( filename )
    read( filename )
    @version[1] = @version[1] + 1
    write( filename )
  end # inc_minor

  def inc_build( filename )
    read( filename )
    @version[2] = @version[2] + 1
    write( filename )
  end # inc_build

  def write_setup_ini(filename)
    version = @version.join(".")
    open(filename, 'w') do |f|
      f << "[Info]\n"
      f << "VerInfo=#{version}\n"
    end
  end # write_setup_ini

private

  def write(filename)
    version = @version.join(".")
    open(filename, 'w') { |f| f << version }
  end #write

  def read(filename)
    filepath = filename

    version = ""
    open(filepath) { |f| version = f.gets(nil) }
    version.strip!
    version.chomp!

    a_version = version.split( "." )
    if( a_version.length != 3 )
      puts "ERROR: Version string must be 3 components. Bad string: #{version}"
      return
    end

    a_version.each_index do |i|
      @version[i] = a_version[i].to_i
    end
  end
end # class VersionIncrementer

