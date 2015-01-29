
    
 CREATE TABLE `t_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_no` varchar(32) NOT NULL,
  `patient_name` varchar(64) NOT NULL,
  `mobile` varchar(64) NOT NULL,
  `sex` varchar(16)  NULL,
  `age` varchar(16)  NULL,
  `birthday` datetime NULL,
  `remark` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
CREATE INDEX i_customer_patient_no on t_customer(patient_no);
ALTER TABLE `t_customer`
ADD CONSTRAINT key_patient_no UNIQUE (`patient_no`); 

   
    
CREATE TABLE `t_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_date` varchar(32) NOT NULL,
  `booking_index` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `patient_no` varchar(64) NOT NULL,
  `case_no` varchar(64) NOT NULL,
  `mobile` varchar(64) NOT NULL,
  `comment` varchar(256) DEFAULT NULL,
  `treat_date` datetime NOT NULL,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
CREATE INDEX i_booking_date on t_booking(Booking_date);

CREATE TABLE `t_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_no` varchar(32) NOT NULL,
  `patient_name` varchar(64) NOT NULL,
  `sex` varchar(16)  NULL,
  `age` varchar(16)  NULL,
  `mobile` varchar(32) NOT NULL,
  `old_mobile` varchar(1024) NULL,
  `comment` varchar(256) DEFAULT NULL,
  `json_id` int(11) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
CREATE INDEX i_patient_name on t_patient(patient_name);
CREATE INDEX i_patient_mobile on t_patient(mobile);

CREATE TABLE `t_recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_no` varchar(32) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `patient_no` varchar(64) NOT NULL,
  `patient_name` varchar(64) DEFAULT NULL,
  `mobile` varchar(32) DEFAULT NULL,
  `age` varchar(16) DEFAULT NULL,
  `sex` varchar(16) DEFAULT NULL,
  `patient_comment` varchar(256) DEFAULT NULL,
  `dingxing` varchar(64) DEFAULT NULL,
  `dingbing` varchar(64) DEFAULT NULL,
  `dingzheng` varchar(64) DEFAULT NULL,
  `comment` varchar(256) DEFAULT NULL,
  `suitnum` varchar(32) DEFAULT NULL,
  `json_id` int(11) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

ALTER TABLE `t_recipe` ADD COLUMN `age` VARCHAR(16)  NULL AFTER `mobile`;
ALTER TABLE `t_recipe` ADD COLUMN `sex` VARCHAR(16)  NULL AFTER `age`;
ALTER TABLE `t_recipe` ADD COLUMN `patient_comment` VARCHAR(256)  NULL AFTER `sex`;
ALTER TABLE `t_recipe` ADD COLUMN `doctor_name` VARCHAR(32)  NULL AFTER `suitnum`;



CREATE TABLE `t_recipe_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `medicine` varchar(32) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `unit` varchar(16) NOT NULL,
  `remark` varchar(64) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;


CREATE TABLE `t_json` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_string` varchar(21000) NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;

CREATE TABLE `t_json_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_string` varchar(21000) NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;

CREATE TABLE `t_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `binarydata` BLOB ,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `t_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(64) not null,
  `value` varchar(64) not null,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `t_medicine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(32) NOT NULL,
  `price` varchar(32) NOT NULL,
  `short_name` varchar(32) NOT NULL,
  `update_date` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX i_medicine_name on t_medicine(medicine_name);


drop PROCEDURE get_history_recipe;
DELIMITER //

CREATE  PROCEDURE `get_history_recipe`(
        IN  p_mobileNo VARCHAR(32))
BEGIN
    DECLARE return_value VARCHAR(20000);
    DECLARE err_no  VARCHAR(32);
    DECLARE err_msg VARCHAR(128);
    DECLARE run_flag INT;
    DECLARE new_id INT;
    DECLARE s_flag int default 0;  
    DECLARE str_a VARCHAR(1024);
    DECLARE str_b VARCHAR(8192);
    DECLARE str_all VARCHAR(128) DEFAULT '';
    
    
    DECLARE v_patient_id INT;

    DECLARE cursor_AAA CURSOR FOR SELECT json_id FROM t_recipe WHERE patient_id=v_patient_id ORDER BY id DESC;
    #设置一个终止标记    
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET s_flag=1;  

    SET return_value = '';
    SET err_no = 'e000000';
    SET err_msg = '';
    SET run_flag = 0;


    IF p_mobileNo IS NULL OR p_mobileNo = '' THEN
        SET  return_value = '{run_result:"run_error", err_msg:"p_mobileNo is null or blank.", return_data:{} }';
            
    ELSE 
        SELECT id INTO v_patient_id FROM t_patient WHERE mobile=p_mobileNo;
            
    END IF;

    IF run_flag = 0 AND v_patient_id IS NOT NULL THEN
        SET return_value = '{run_result:"run_start", return_data:{mobile:XXXXXX} }';  
        
        #打开游标  
        OPEN cursor_AAA;
        #获取游标当前指针的记录，读取一行数据并传给变量a,b  
        fetch  cursor_AAA into str_b;  
        #开始循环，判断是否游标已经到达了最后作为循环条件   
        while s_flag <> 1 do  
             
            select json_string into str_a from t_json where id=str_b;
            set str_all =  concat(str_all,str_a); 
            #读取下一行的数据  
            fetch  cursor_AAA into str_b;  
        end while;  
        #关闭游标  
        CLOSE cursor_AAA ; 


    ELSE
        SET return_value = '{run_result:"run_error", return_data:{} }';
        SET run_flag = 2; 
    END IF;

    INSERT INTO t_json_temp (json_string) VALUES(str_all);
    SET new_id=LAST_INSERT_ID();


    SELECT * FROM t_json_temp where id=new_id;


END
//






CREATE PROCEDURE plogin()

BEGIN   
    DECLARE s_flag int default 0;  
    DECLARE str_b VARCHAR(128);
    DECLARE str_all VARCHAR(128);
    declare int_abc int(11) default 0;

 
    DECLARE cursor_AAA CURSOR FOR SELECT json_id FROM t_recipe where id=int_abc;
    #设置一个终止标记    
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET s_flag=1;  
    set int_abc = 1;
    #打开游标  
    OPEN cursor_AAA;
    set str_all = 'xxx';

    
    #获取游标当前指针的记录，读取一行数据并传给变量a,b  
    fetch  cursor_AAA into str_b;  
    #开始循环，判断是否游标已经到达了最后作为循环条件   
    while s_flag <> 1 do  
        set str_all =  concat(str_all,str_b);  
        #读取下一行的数据  
        fetch  cursor_AAA into str_b;  
    end while;  
    #关闭游标  
    CLOSE cursor_AAA ; 

    select str_all;
 
END 
 //



DELIMITER ;
