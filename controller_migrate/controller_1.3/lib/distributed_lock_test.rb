require_relative 'distributed_lock'
require_relative 'dbutils'
require_relative "db_config"
require_relative "config"
require_relative "logd"


@name="job_reservation"
@lock=false


	@mutex = Mutex.new
	@db = DBUtils.get_new
    $dbt = DBUtils.get_new

	def get(name)
		if not @db then @db = DBUtils.get_new end
		ok = false
		while not ok
			@mutex.synchronize do
            #print "in mutex.synchronize \n"
			# TO TEST (transaction) or watch code, must be a Mutex like mine... +
			# BEGIN and COMMIT
			    #$dbt.transaction do |dbt|
				#@db.do "BEGIN"
                @db.transaction {
				locks = @db.select_one("SELECT * FROM locks
							WHERE id='1' FOR UPDATE")
				if locks[name]
			    	if locks[name] == 0
						@db.do "UPDATE locks SET #{name}='1' WHERE id ='1'"
						ok = true
                        @db.commit
					end
				else
					$log.error("Trying to get a non existant lock: #{name}")
					ok = true
				end
                }
				#@db.do "COMMIT"
			end
		end
	end

get(@name)

exit

	def release()
		return release(@name)
	end

	def release(name)
		@@mutex.synchronize do
			#@@db.do "BEGIN"
			@@db.do "UPDATE locks SET #{name}='0' WHERE id ='1'"
			#@@db.do "COMMIT"
		end
	end


