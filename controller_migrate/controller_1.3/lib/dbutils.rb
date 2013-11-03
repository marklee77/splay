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


require_relative 'sdbi'
#require 'mysql' # raluca: it doesn't seem to be needed

class DBUtils

	def self.get_new
		#$log.info("New DB connection") #uncomment this
		# We do not catch exceptions here because if there is a problem the application must end TODO exception
		db = SDBI.connect(SplayControllerConfig::SQL_TYPE, { :host => SplayControllerConfig::SQL_HOST, :username => SplayControllerConfig::SQL_USER, :password => SplayControllerConfig::SQL_PASS, :database => SplayControllerConfig::SQL_DB, }) #db = DBI.connect("dbi:#{SplayControllerConfig::SQL_TYPE}:#{SplayControllerConfig::SQL_DB}:#{SplayControllerConfig::SQL_HOST}", SplayControllerConfig::SQL_USER, SplayControllerConfig::SQL_PASS)
		#db['AutoCommit'] = true

		# Permit debug but slow down things
		if not SplayControllerConfig::Production
			#db = LogObject.new(db, "DB") #uncomment this
		end
		Thread.new do
			loop do
				if not db.ping()
					break
				end
				sleep 3600
			end
		end
		return db
	end

	def self.get_new_mysql # raluca: needed?
		$log.info("New DB connection (MySQL)")
		# We do not catch exceptions here because if there is a problem the application must end. TODO exception
		db = Mysql.new(SplayControllerConfig::SQL_HOST, SplayControllerConfig::SQL_USER, SplayControllerConfig::SQL_PASS, SplayControllerConfig::SQL_DB)
		db.autocommit(false)

		Thread.new do
			loop do
				if not db.ping()
					break
				end
				sleep 3600
			end
		end
		return db
	end
end
