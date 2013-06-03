Index: splay-list-splayds.lua
===================================================================
--- splay-list-splayds.lua	(revision 2661)
+++ splay-list-splayds.lua	(working copy)
@@ -98,16 +98,28 @@
 			DELETED = 0
 		}
 		--prints the result
+		local hosts={}
+		local h_c=0
 		print_line(NORMAL, "Splayd List =")
 		for _,v in ipairs(json_response.result.splayd_list) do
 			print_line(QUIET, "\tsplayd_id="..v.splayd_id..", ip="..v.ip..", status="..v.status)
 			print_line(QUIET, "\t\tkey="..v.key)
 			stats[v.status] = stats[v.status] + 1
+			if  hosts[v.ip]==nil then 
+				hosts[v.ip]=1
+				h_c=h_c+1 
+			else hosts[v.ip]=hosts[v.ip]+1 end
 		end
-		print_line(NORMAL, "Totals =")
+		print_line(NORMAL, "Totals:")
 		for k,v in pairs(stats) do
 			print_line(NORMAL, k.." = "..v.." ")
 		end
+		print_line(NORMAL, "Total hosts:"..h_c)
+		print_line(NORMAL, "Per host totals:")
+		for k,v in pairs(hosts) do
+			print_line(NORMAL, "HOST:"..k.." TOTAL_SPLAYDS:"..v)
+			--TODO : make per_host STATISTICS, add (U:n,R:m,P:x,A:y,D:z) after the total
+		end
 		print_line(NORMAL, "")
 	end
 
