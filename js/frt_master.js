var fs = require('fs');
var path = require('path');
var mysql = require('mysql');
var process = require('child_process');

function getEnvPath(module_name){
	var retVal = null;
	var base_path = "/Volumes/";
	var module_path = "";
	var config_filename = "data/config.json";

	if( module_name == "frt_booking"){
		module_path = "/FRT_booking/";
	}else if( module_name == "frt_input"){
		module_path = "/chufang_input/";
	}else if( module_name == "frt_aid"){
		module_path = "/FRT_aid/";
	}else if( module_name == "frt_cashier"){
		module_path = "/FRT_Cashier/";
	}else{
		module_path = "";
	}

	// 获取所有的 U盘 的路径
	var UDiskPaths = fs.readdirSync(base_path);

	// 循环查找路径下有没有指定的文件
	for(i=0; i<UDiskPaths.length; i++ ){
		var fullPath = base_path + UDiskPaths[i] + module_path + config_filename;
		
		if( fs.existsSync(fullPath) ){
			retVal = base_path + UDiskPaths[i] + module_path;
			console.log( fullPath );
		}
	}
	return retVal;
}


function getYMD( aDate ){
	var year = aDate.getFullYear();
	var month = aDate.getMonth()+1;
	var day = aDate.getDate();

	var strDate = "" + year + "-" + month + "-" + day;
	//console.log(strDate);

	return strDate;

}

function isblank(strA){
	if(strA){
		if( "string" === typeof(strA) ){
			if( "" === strA.trim()){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}else{
		return true;
	}
}

// 从文件中读入Json
function getJson2obj( strFilename ){
	var aJson = {};
	//console.log(strFilename);
	if(fs.existsSync( strFilename ) ){
		var strJson = fs.readFileSync(strFilename);
		//console.log(strJson);
	    aJson = JSON.parse(strJson);
	}
	return aJson;
} 



// 把对象以 Json 格式写入文件。
function save2Json( filename, obj){
	var jsonStr = JSON.stringify(obj);
	// Write a file:
	console.log( "jsonStr = ###" + jsonStr + "###" );
	fs.writeFileSync( filename , jsonStr);
}

/*  连接Mysql数据库   */
function getConn(){
	
	var conn = mysql.createConnection({
	    host: 'localhost',
	    user: 'root',
	    password: '',
	    database:'frt',
	    port: 3306,
	    multipleStatements: true
	});
	return conn;
}

var add_msg = function( obj, msg ){
    obj.message += "\n" + msg;
  };

var show_msg = function(msg, delay){
  var obj = document.getElementById("AUTO_HIDE_MSG");
  if(obj === null ){
  	obj = document.createElement('span');
  	obj.id = "AUTO_HIDE_MSG";
  	document.body.appendChild(obj);
  }
  if( msg === undefined ){
  	obj.innerHTML="执 行 成 功";
  }else{
  	obj.innerHTML=msg;
  }

  var delay_time = 1200;
  if( delay === undefined ){
  	delay_time = 1200;
  }else{
  	delay_time = delay;
  }
  
  obj.style.display = "block";
  setTimeout(function(){
                         obj.style.display = "none";
                        }, delay_time);
};

