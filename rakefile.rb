##############################################################################
# File:       rakefile.rb
# Purpose:    Build tasks for rakeutils gem
#
# Author:     Jeff McAffee 05/02/2010
# Copyright:  Copyright (c) 2010, Jeff McAffee
#             All rights reserved. See LICENSE.txt for details.
# Website:    http://JeffMcAffee.com
##############################################################################

require "bundler/gem_tasks"
require 'rake/clean'

CLEAN.include("pkg")
CLOBBER.include("pkg")
