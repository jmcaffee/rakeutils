##############################################################################
# File:: fileGenTask.rb
# Purpose:: Generate a file from a template file using data from a YML file.
# 
# Author::    Jeff McAffee 03/03/2010
# Copyright:: Copyright (c) 2010 kTech Systems LLC. All rights reserved.
# Website::   http://ktechsystems.com
##############################################################################



require 'webutils/parseTemplate'   # r:\tools\ruby\webutils\lib\parseTemplate
require 'yaml'
require 'fileutils'
=begin
require 'logger'

$LOG = Logger.new( 'FILEGEN.log', 2, 40 * 1024 )     # Rotate 3 logs, each no larger than 40k
$LOG.level = Logger::DEBUG
$LOG.info "*************************************************"
$LOG.info "Logging started for DrupalTplConverter program."
$LOG.info "*************************************************"
=end

class DataFile

  attr_accessor :rootDir

  
  def initialize(rootDir = nil)
        #$LOG.debug "DataFile::initialize"
    @rootDir = rootDir
    
    if( rootDir )
        @rootDir = File.rubypath(@rootDir)
        if( !File.exists?(@rootDir))
          #$LOG.debug "Creating directory: #{@rootDir}"
          FileUtils.mkdir(@rootDir)
        end
    end
  end # initialize
  
  
  def write(filename, data)
        #$LOG.debug "DataFile::write"
    filepath = filename
    if( @rootDir )
        filepath = File.join(@rootDir, filename)
    end
    #$LOG.debug "Filepath: #{filepath}"
    
    open(filepath, 'w') { |f| YAML.dump(data, f) }
    
  end #write


  def read(filename)
        #$LOG.debug "DataFile::read"
    filepath = filename
    if( @rootDir )
        filepath = File.join(@rootDir, filename)
    end
    
    data = {}
    
    open(filepath) { |f| data = YAML.load(f) }
    data
  end
  
  
end # class DataFile




# This class defines a generator object that creates a file from a template and a YML data file.

class FileGenTask
    
    


    # Constructor
    # verbose:: verbose output flag. Default = false
    def initialize(verbose=false)
        @src = ""
        @dest = ""
        @dataFile = ""
        @startDelim = "@"
        @stopDelim = "@"
        @verbose = verbose
        
    end # initialize
    
    
    # Set token delimiters
    # start:: start delimiter char
    # stop:: stop delimiter char
    def setDelimeters(start, stop)
        @startDelim = start
        @stopDelim = stop
        puts "FileGenTask: Setting token delimeters to #{@startDelim}, #{@stopDelim}" if @verbose
    end # setDelimeters


    # Generate files.
    # src:: source template file
    # dest:: name of file to output.
    # data:: string or hash. if a string, it will be treated as a YML filename.
    def generate(src, dest, data)
        puts "FileGenTask: Generating file [ #{dest} ] from [ #{src} ]" if @verbose
        if(data.class == String)
          loadData(data)
        else
          if( data.class != Hash )
            puts "* ERROR: FileGenTask::generate - data must be string (YML filename) or hash *"
            return unless (data.class == Hash)
          end
          @data = data
        end
        
        parseSrcTo( src, dest )
    end # generate
    
    
    # Load data from YAML based data file.
    # dataFile:: name/path of YAML based data file
    def loadData(dataFile)
        puts "FileGenTask: Loading data from YML file [ #{dataFile} ]" if @verbose
        df = DataFile.new
        @data = df.read( dataFile )
    end # loadData
    
    
    # Parse the source file and create the destination file.
    # src:: source template file
    # dest:: Destination filename and path
    def parseSrcTo(src, dest)
        pt = ParseTemplate.new(false, @startDelim, @stopDelim)
        
        @data.each do |t, v|
            pt.addToken( t, v )
        end
        pt.parse( src, dest )
        
    end # parseSrcTo
    
    
    
    
end # class FileGenTask
