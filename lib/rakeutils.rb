###############################################################################
# File:       rakeutils.rb
# Purpose:    rakeutils master include file
#
# Author:     Jeff McAffee 10/25/2008
# Copyright:  Copyright (c) 2008, Jeff McAffee
#             All rights reserved. See LICENSE.txt for details.
# Website:    http://JeffMcAffee.com
##############################################################################
require 'rakeutils/version'

module RakeUtils

end

require 'logger'

require 'rakeutils/clapp'
require 'rakeutils/filegentask'
require 'rakeutils/innotask'
require 'rakeutils/javacctask'
require 'rakeutils/jjtreetask'
require 'rakeutils/ocratask'
require 'rakeutils/text2rtf'
require 'rakeutils/versioninc'
require 'rakeutils/ziptask'

#require 'find'
#
#class_files = File.join( File.dirname(__FILE__), 'rakeutils', '*.rb')
#$: << File.join( File.dirname(__FILE__), 'rakeutils')                   # Add directory to the include file array
#Dir.glob(class_files) do | class_file | 
#  require class_file[/\w+\.rb$/]
#end

