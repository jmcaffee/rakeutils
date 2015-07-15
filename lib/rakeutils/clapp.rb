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
  # app_path:: absolute path to application to control
  def initialize(app_path)
      @app_path = app_path
  end # initialize

  # Apply quotes around a text value (helper function for GLT class)
  # val:: Value to apply quotes to
  # returns:: quoted value
  def quote_value(val)
    q_vals = '"' + "#{val}" + '"'

    return q_vals
  end # quote_value

  # Apply quotes around an array of text values (helper function)
  # values:: Value to apply quotes to
  # returns:: quoted value
  def quote_all_values(values)
    q_vals = []
    values.each do |val|
      q_vals << quote_value(val)
    end

    return q_vals
  end # quote_all_values

  # Return a normalized directory path (if the path is to a file, return the file's directory). This will make sure that the path is quoted if it contains spaces.
  # dirpath:: Path to directory
  # returns:: Path to directory
  def normalize_dir_path(dirpath)
    if (!File.directory?(dirpath))           # This is not a path to a directory...
      if(File.exists?(dirpath))
        dirpath = File.dirname(dirpath)
      end
    end

    if(!dirpath.include?('"') && !dirpath.include?("'"))  # Do not add quotes around path if it already contains quotes.
      if(dirpath.include?(' '))                                # Add quotes around path if it contains spaces.
        dirpath = quote_value(dirpath)
      end
    end

    return dirpath
  end # normalize_dir_path

  # Convert windows path seperators to ruby (backslash to forward slash).
  # path:: path to convert
  # returns:: converted path
  def rubyize_path(path)
    return path.gsub(/\\/, "/")
  end # rubyize_path

  # Convert ruby path seperators to windows ( forward slash to backslash).
  # path:: path to convert
  # returns:: converted path
  def windowize_path(path)
    return path.gsub(/\//, "\\")
  end # windowize_path

  # Execute application.
  # cmd_line:: Command line to pass to the application
  # can_throw:: If true, throw exception if command fails.
  # throws:: Exception if command failed. 
  def execute(cmd_line, can_throw=true)
    app_cmd = "#{@app_path} #{cmd_line}"
    puts "Executing: #{app_cmd}"
    if( !File.exists?(@app_path) )
      raise "Invalid application path: #{@app_path}"
    end

    if( !Kernel.system("#{app_cmd}") && can_throw )
        raise "Application threw an exception for the command: ".concat(app_cmd)
    end
  end # execute
end # class CLApp
