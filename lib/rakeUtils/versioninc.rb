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

    # Constructor
    def initialize()
        @version = [0,0,0]
    end # initialize


    def version()
        @version.join(".")
    end
    
    
    def incMajor( filename )
        read( filename )
        @version[0] = @version[0] + 1
        write( filename )
    end # incMajor
    
    def incMinor( filename )
        read( filename )
        @version[1] = @version[1] + 1
        write( filename )
    end # incMinor
    
    def incBuild( filename )
        read( filename )
        @version[2] = @version[2] + 1
        write( filename )
    end # incBuild
  

    def writeSetupIni(filename)
        version = @version.join(".")
        open(filename, 'w') do |f| 
            f << "[Info]\n"
            f << "VerInfo=#{version}\n"
        end
    
    end # writeSetupIni
    
    
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
        
        aVersion = version.split( "." )
        if( aVersion.length != 3 )
            puts "ERROR: Version string must be 3 components. Bad string: #{version}"
            return
        end
        
        aVersion.each_index do |i|
            @version[i] = aVersion[i].to_i
        end
    end
  
      
end # class VersionIncrementer
