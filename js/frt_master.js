var fs = require('fs');
var mysql = require('mysql');

function getYMD( aDate ){
	var year = aDate.getFullYear();
	var month = aDate.getMonth()+1;
	var day = aDate.getDate();

	var strDate = "" + year + "-" + month + "-" + day;
	console.log(strDate);

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
	if(fs.existsSync( strFilename) ){
		var strBookingList = fs.readFileSync(strFilename);
	    aJson = JSON.parse(strBookingList);
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