require 'rdbi/driver/mysql'
require 'time'

class SDBI

    # database handler
    @@dbh = nil

    # connects to a database; singleton
    def self.connect(driver, args)
        @@dbh = RDBI.connect(driver, args) unless @@dbh and @@dbh.connected?

        if not(@@dbh.connected?) then 
            print("Could not connect to the database.\n")
        end

        return self
    end

    # disconnects from the database
    def self.disconnect
        @@dbh.disconnect

        if @@dbh.connected? then 
            print("Error disconnecting from the database.\n")
        end
    end

    # executes a statement
    def self.do(stmt, *bindvars)
        start_time = Time.now
        @@dbh.execute_modification(stmt,*bindvars)
        end_time = Time.now
        duration = (end_time - start_time) * 1000000

        print("execute do Query is ")
        print(stmt)
        print("\nTime spent in do is ")
        print(duration)
        print("\n")
    end


    # executes a statement and returns the first row from the result
    def self.select_one(stmt, *bindvars)
        #start_time = Time.now
        row = nil
        @@dbh.execute(stmt,*bindvars) do |res|
            row = res.fetch(:first, :Struct)
            if !res.sth.finished? then res.sth.finish end
        end
        #@@dbh.execute(stmt, *bindvars) do |res|
        #    row = res.fetch(:first, :Struct)
        #end

        #end_time = Time.now
        #duration = (end_time - start_time) * 1000000

        #print("Select one Query is ")
        #print(stmt)
        #print("\nTime spent in do is ")
        #print(duration)
        #print("\n")
        row
    end

    # executes a statement and returns all the rows from the result; if a block is given, it is executed 
    def self.select_all(stmt, *bindvars, &p)
        rows=[]
        
        @@dbh.execute(stmt,*bindvars) do |res|
            rows = res.fetch(:all, :Struct)
            if !res.sth.finished? then res.sth.finish end
        end

        if block_given?
            rows.each(&p)
        else
            rows
        end
    end

    def self.transaction(&block)
        @@dbh.transaction(&block)
    end

    def self.commit
        @@dbh.commit
    end

end
