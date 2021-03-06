# -*- coding: utf-8 -*-  
import codecs
import json
import MySQLdb
import os
import shutil
import sys
import mydb

def dumpToJson( ):
  bigJson = ""
  try:
      conn = mydb.getConn()
      cur = conn.cursor( cursorclass=MySQLdb.cursors.DictCursor )
      cur.execute("SELECT id,patient_no,patient_name,concat('****', right(mobile, 4)) as mobile,sex,age,remark FROM t_customer ")
      rs = cur.fetchall()
      bigJson = json.dumps(rs, ensure_ascii=False,indent=2)
      cur.close()
      conn.close()
   
  except MySQLdb.Error,e:
     print "Mysql Error %d: %s" % (e.args[0], e.args[1])

  return bigJson

#print len(sys.argv)
if len(sys.argv) != 2 :
  print 'usage: python dumpCustomer.py jsonFileFullPath '
  exit()

all_json =  dumpToJson(  )

"""  将字符串写入文件  """
json_file = codecs.open( sys.argv[1] + 'data/allCustomer.json','w','utf-8')
json_file.write(all_json)
json_file.close()


     







