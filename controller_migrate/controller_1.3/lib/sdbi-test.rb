require_relative 'sdbi'
require_relative 'db_config'
require_relative 'config'

class TestMe

print("New DB connection\n")

db = SDBI.connect(SplayControllerConfig::SQL_TYPE, { :host => SplayControllerConfig::SQL_HOST, :username => SplayControllerConfig::SQL_USER, :password => SplayControllerConfig::SQL_PASS, :database => SplayControllerConfig::SQL_DB, })


#TestMe.class_variable_set(:@@scheduler, 'trace')   


#db.select_all "SELECT splayd_id FROM splayd_selections" do |id|
#    print(id)
#    print("\n")
#end

#db.select_all "SELECT host FROM blacklist_hosts" do |row|
#	print row[0]
#    print "\n"
#end

#print(db.select_all "SELECT splayds.* FROM splayds,libs WHERE libs.lib_arch=splayds.architecture")

lib_name="hello.so"
print(db.select_all("SELECT id, lib_name FROM libs WHERE lib_name='#{lib_name}'"))
print("\n")



#db.select_all("SELECT ref FROM jobs") {print("hi")}

#print(db.select_one "SELECT status FROM splayds")

#db.select_all "SELECT status FROM splayds" do |row|
#	print(row[0] + "\n")
#end



db.disconnect

end


#print("Select\n")
#print(db.execute("SELECT host FROM blacklist_hosts").fetch(:all))
#db.execute("SELECT host FROM blacklist_hosts").fetch(:all) do |row|
#    print(row[0])
#end
#print("\n")
#print(db.execute("SELECT * FROM splayds WHERE status='RESET'").fetch(:all)) #do |splayd|
    #print(splayd)
    #print(db.execute("SELECT * FROM actions WHERE splayd_id='#{splayd['id']}' AND command='BLACKLIST'").fetch(:first))
#end
#print("Insert\n")

#print("Disconnecting from the db\n")
#db.disconnect
#if db.connected? then
#    print("Connected\n")
#else
#    print("Disconnected\n")
#end

#db = Mysql.new(SplayControllerConfig::SQL_HOST, SplayControllerConfig::SQL_USER, SplayControllerConfig::SQL_PASS, SplayControllerConfig::SQL_DB)
#db.autocommit(false)
