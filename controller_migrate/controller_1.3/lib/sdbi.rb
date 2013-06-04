require 'rdbi/driver/mysql'

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
        res = @@dbh.execute(stmt, *bindvars)

        if !res.sth.finished? then res.sth.finish end
    end


    # executes a statement and returns the first row from the result
    def self.select_one(stmt, *bindvars)
        res = @@dbh.execute(stmt, *bindvars)
        row = res.as(:Struct).fetch(:first)

        if !res.sth.finished? then res.sth.finish end

        row
    end

    # executes a statement and returns all the rows from the result; if a block is given, it is executed 
    def self.select_all(stmt, *bindvars, &p)
        res = @@dbh.execute(stmt, *bindvars)
        rows = res.as(:Struct).fetch(:all)

        if !res.sth.finished? then res.sth.finish end

        if block_given?
            rows.each(&p)
        else
            rows
        end

    end

end
