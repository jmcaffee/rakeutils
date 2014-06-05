######################################################################################
#
# rakeUtils.rb
#
# Jeff McAffee   10/25/08
#
# Purpose: rakeUtils master include file
#
######################################################################################

# Require source files

require 'find'
require 'logger'

class_files = File.join( File.dirname(__FILE__), 'rakeutils', '*.rb')
$: << File.join( File.dirname(__FILE__), 'rakeutils')                   # Add directory to the include file array
Dir.glob(class_files) do | class_file | 
  require class_file[/\w+\.rb$/]
end

