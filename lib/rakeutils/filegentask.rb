##############################################################################
# File::    filegentask.rb
# Purpose:: Generate a file from a template file using data from a YML file.
#
# Author::    Jeff McAffee 03/03/2010
# Copyright:: Copyright (c) 2010 kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################

require 'yaml'
require 'fileutils'

require 'ktutils/parse_template'

class DataFile

  attr_accessor :root_dir

  def initialize(rootdir = nil)
    @root_dir = rootdir

    if( rootdir )
      @root_dir = File.rubypath(@root_dir)
      if( !File.exists?(@root_dir))
        FileUtils.mkdir(@root_dir)
      end
    end
  end

  def write(filename, data)
    filepath = filename
    if( root_dir )
      filepath = File.join(root_dir, filename)
    end

    open(filepath, 'w') { |f| YAML.dump(data, f) }
  end

  def read(filename)
    filepath = filename
    if( root_dir )
      filepath = File.join(root_dir, filename)
    end

    data = {}

    open(filepath) { |f| data = YAML.load(f) }
    data
  end
end # DataFile


# Define a generator object that creates a file from a template and a YML
# data file.
class FileGenTask

  # Constructor
  # verbose:: verbose output flag. Default = false
  def initialize(verbose=false)
    @src = ""
    @dest = ""
    @data_file = ""
    @start_delim = "@"
    @stop_delim = "@"
    @verbose = verbose
  end

  # Set token delimiters
  # start:: start delimiter char
  # stop:: stop delimiter char
  def set_delimiters(start, stop)
    @start_delim = start
    @stop_delim = stop
    puts "FileGenTask: Setting token delimeters to #{@start_delim}, #{@stop_delim}" if @verbose
  end

  # Generate files.
  # src:: source template file
  # dest:: name of file to output.
  # data:: string or hash. if a string, it will be treated as a YML filename.
  def generate(src, dest, data)
    puts "FileGenTask: Generating file [ #{dest} ] from [ #{src} ]" if @verbose
    if(data.class == String)
      load_data(data)
    else
      if( data.class != Hash )
        puts "* ERROR: FileGenTask::generate - data must be string (YML filename) or hash *"
        return unless (data.class == Hash)
      end
      @data = data
    end

    parse_src_to( src, dest )
  end

  # Load data from YAML based data file.
  # data_file:: name/path of YAML based data file
  def load_data(data_file)
    puts "FileGenTask: Loading data from YML file [ #{data_file} ]" if @verbose
    df = DataFile.new
    @data = df.read( data_file )
  end

  # Parse the source file and create the destination file.
  # src:: source template file
  # dest:: Destination filename and path
  def parse_src_to(src, dest)
    pt = Ktutils::ParseTemplate.new(@start_delim, @stop_delim)

    @data.each do |t, v|
      pt.add_token( t, v )
    end
    pt.parse( src, dest )
  end
end # class FileGenTask
