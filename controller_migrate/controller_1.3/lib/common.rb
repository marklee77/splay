## Splay Controller ### v1.3 ###
## Copyright 2006-2011
## http://www.splay-project.org
## 
## 
## 
## This file is part of Splay.
## 
## Splayd is free software: you can redistribute it and/or modify 
## it under the terms of the GNU General Public License as published 
## by the Free Software Foundation, either version 3 of the License, 
## or (at your option) any later version.
## 
## Splayd is distributed in the hope that it will be useful,but 
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
## See the GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Splayd. If not, see <http://www.gnu.org/licenses/>.

require 'logger' # Logger::Error
$log = Logger.new(STDERR)
#$log.level = Logger::DEBUG
$log.level = Logger::ERROR
$log.datetime_format = "%H:%M:%S "

$bench = Logger.new(STDERR)
$bench.level = Logger::DEBUG
$bench.datetime_format = "%H:%M:%S "

require 'socket' # SocketError and SystemCallError (Errno::*)
require 'timeout' # Timeout::Error
require 'openssl' # OpenSSL::OpenSSLError
# require 'rubygems'
# require 'fastthread'
require 'thread' # ThreadError
require 'fileutils'
require 'dbi' # DBI::Error
require 'resolv'

require_relative 'db_config'
require_relative 'config'
require_relative 'log_object'
require_relative 'dbutils'

require "json" #gem install json
require_relative 'llenc'
require_relative 'array_rand'
require_relative 'utils'
require_relative 'distributed_lock'

if SplayControllerConfig::Localize
  require_relative 'localization'
end

$db = DBUtils.get_new
# $new_db = DBUtils.get_new_mysql

BasicSocket.do_not_reverse_lookup = true
$DEBUG = false
$VERBOSE = false
OpenSSL::debug = false

if not SplayControllerConfig::PublicIP
	$log.warn("You must set your public ip in production mode.")
end
