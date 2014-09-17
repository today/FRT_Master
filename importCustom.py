# -*- coding: utf-8 -*-  
import codecs
import json
import MySQLdb
import os
import shutil
import sys
import mydb

def checkOptionValue( obj, keys ):
  for k in keys:
    if not obj.has_key(k) :
      obj[k] = ""

def getVals( obj, keys ):
  vals = []
  for k in keys:
    vals.append( unicode(obj[k]) )
  return vals

def saveCustom( customs ):
  optVals = ['mobile','sex','age','remark']

  try:
      conn = mydb.getConn()
      cur = conn.cursor()

      for custom in customs :

        checkOptionValue(custom, optVals )
        p_no = str( custom['patient_no'] )
        strSql1 = "SELECT * FROM t_customer WHERE patient_no='" + p_no + "' "
        print strSql1
        cur.execute(strSql1)
        if cur.fetchone() :
          # 存在，则执行update
          values = getVals(custom, [ 'patient_name', 'mobile','sex','age','remark','patient_no'])
          strSql2 = "UPDATE t_customer SET  "  \
            + "`patient_name`=%s, `mobile`=%s, `sex`=%s, `age`=%s, `remark`=%s "  \
            + "  WHERE patient_no=%s" 
          print strSql2
          cur.execute( strSql2, values )
          conn.commit()
        else :
          # 不存在，执行insert
          values = getVals(custom, ['patient_no', 'patient_name', 'mobile','sex','age','remark'])
          strSql3 = "INSERT INTO t_customer ( `patient_no`, `patient_name`, `mobile`, `sex`, `age`, `remark`) " \
            + " VALUES (%s,%s,%s,%s,%s,%s) "
          print strSql3
          cur.execute( strSql3, values )
          conn.commit()
      
      cur.close()
      conn.close()
   
  except MySQLdb.Error,e:
     print "Mysql Error %d: %s" % (e.args[0], e.args[1])

  return "success"

#print len(sys.argv)
if len(sys.argv) != 2 :
  print 'usage: python importCustom.py jsonFileFullPath '
  exit()

"""  读文件  """
json_file = codecs.open( sys.argv[1] + 'data/new_custom.json','r','utf-8')
strJson = json_file.read()
json_file.close()

""" 转为对象 """
customsArray = json.loads( strJson );
print customsArray
run_flag =  saveCustom( customsArray )

"""  操作成功，写空数组到文件中  """
if run_flag == "success" :
  json_file = codecs.open( sys.argv[1] + 'data/new_custom.json','w','utf-8')
  strJson = json_file.write("[]")
  json_file.close()



     







