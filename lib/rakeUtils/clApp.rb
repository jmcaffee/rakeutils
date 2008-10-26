######################################################################################
#
# clApp.rb
#
# Jeff McAffee   10/25/08
#
# Purpose: CLApp is a base class for command line application classes.
# CLApp is used to create classes that call 3rd party command line apps.
#
######################################################################################

# Base class that provides common functionality for command line application caller classes.

class CLApp


  
    # Constructor
    # appPath:: absolute path to application to control
    def initialize(appPath)
        @appPath = appPath

    end # initialize

    
    # Apply quotes around a text value (helper function for GLT class)
    # val:: Value to apply quotes to
    # returns:: quoted value
    def quoteValue(val)
        qVals = '"' + "#{val}" + '"'

        return qVals
    end # quoteValue
  

    # Apply quotes around an array of text values (helper function)
    # values:: Value to apply quotes to
    # returns:: quoted value
    def quoteAllValues(values)
        qVals = []
        values.each do |val|
            qVals << quoteValue(val)
        end

        return qVals
    end # quoteAllValues


    # Return a normalized directory path (if the path is to a file, return the file's directory). This will make sure that the path is quoted if it contains spaces.
    # dirpath:: Path to directory
    # returns:: Path to directory
    def normalizeDirPath(dirpath)
        if (!File.directory?(dirpath))           # This is not a path to a directory...
            if(File.exists?(dirpath))
                dirpath = File.dirname(dirpath)
            end
        end
    
        if(!dirpath.include?('"') && !dirpath.include?("'"))  # Do not add quotes around path if it already contains quotes.
            if(dirpath.include?(' '))                                # Add quotes around path if it contains spaces.
                dirpath = quoteValue(dirpath)
            end
        end
    
        return dirpath
    end # normalizeDirPath
  

    # Execute application.
    # cmdLine:: Command line to pass to the application
    # canThrow:: If true, throw exception if command fails.
    # throws:: Exception if command failed. 
    def execute(cmdLine, canThrow=true)
        appCmd = "#{@appPath} #{cmdLine}"
        puts "Executing: #{appCmd}"
    
        if( !Kernel.system("#{appCmd}") && canThrow )
            raise "Application threw an exception for the command: ".concat(appCmd)
        end
    
    end # execute


end # class Tex2Rtf
