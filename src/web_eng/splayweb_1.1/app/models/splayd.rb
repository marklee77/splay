## Splayweb ### v1.1 ###
## Copyright 2006-2011
## http://www.splay-project.org
## 
## 
## 
## This file is part of Splayd.
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


class Splayd < ActiveRecord::Base
	belongs_to :user
	has_many :splayd_selections
	has_many :jobs, :through => :splayd_selections
	has_many :splayd_measurements

	def get_last_measurements(id)
		measurements = Splayd_measurement.find(:first, :conditions => [ "splayd_id = ?", id ], :order => "timestamp DESC")
		return measurements
	end

	def get_measurements(id)
		measurements = Splayd_measurement.find(:all, :conditions => [ "splayd_id = ?", id ], :order => "timestamp ASC")
		mstring = ""
		measurements.each { |m|
			if mstring != "" 
				mstring += ", " + m['splayd_id'].to_s + ", " + m['timestamp'].to_s + ", " +
					m['load_1'].to_s + ", " + m['load_5'].to_s + ", " + m['load_15'].to_s + ", " + 
					m['bytes_received'].to_s + ", " + m['bytes_transmitted'].to_s + ", " + 
					m['memory_used'].to_s + ", " + m['slots_in_use'].to_s + ", " + 
					m['sectors_read'].to_s + ", " + m['sectors_written'].to_s
			else
				mstring += m['splayd_id'].to_s + ", " + m['timestamp'].to_s + ", " +
					m['load_1'].to_s + ", " + m['load_5'].to_s + ", " + m['load_15'].to_s + ", " + 
					m['bytes_received'].to_s + ", " + m['bytes_transmitted'].to_s + ", " + 
					m['memory_used'].to_s + ", " + m['slots_in_use'].to_s + ", " + 
					m['sectors_read'].to_s + ", " + m['sectors_written'].to_s
			end
		}
		return mstring
	end
end
