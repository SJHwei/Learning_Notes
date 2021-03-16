#流程控制结构
/*

顺序结构：程序从上往下依次执行；
分支结构：程序从两条或多条路径中选择一条去执行；
循环结构：程序在满足一定条件的基础上，重复执行一段代码。

*/


#一、分支结构

#1.if函数
/*
功能：实现简单的双分支。

语法：if(表达式1，表达式2，表达式3)

执行顺序：如果表达式1成立，则if函数返回表达式2的值，否则返回表达式3的值。

应用：任何地方。

*/

#2.case结构
/*
情况一：类似于java中的switch语句，一般用于实现等值判断
语法：
	case 变量|表达式|字段
	when 要判断的值 then 返回的值1或语句1;
	when 要判断的值 then 返回的值2或语句2;
	...
	else 要返回的值n或语句n;
	end case;

情况二：类似于java中的多重if语句，一般用于实现区间判断
语法：
	case
	when 要判断的条件1 then 返回的值1语句1;
	when 要判断的条件2 then 返回的值2语句2;
	...
	else 要返回的值n语句n;
	end case;
	
注意：该语句可以单独写，例如放在存储过程或函数中，如果要单独写，则必须是 语句n; ，且end后加 case; 。

特点：
    （1）可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，begin end中或begin end的外面；
    （2）可以作为独立的语句去使用，只能放在begin end中。
    （3）如果when中的值满足或条件成立，则执行对应的then后面的语句，并且结束case，如果都不满足，则执行else中的语句或值。
    （4）else可以省略，如果else省略了，并且所有when条件都不满足，则返回null。

*/

#案例：创建存储过程，根据传入的成绩来显式等级，比如传入的成绩：90-100，显示A，80-90，显示B，60-80，显示C，否则显示D。
#注意：要判断的是一个区间，所以使用情况二，情况一判断的是一个值。
DELIMITER $

CREATE PROCEDURE test_case(IN score INT)
BEGIN
	CASE
	WHEN score>=90 AND score <=100 THEN SELECT 'A';
	WHEN score>=80 THEN SELECT 'B';
	WHEN score>=60 THEN SELECT 'C';
	ELSE SELECT 'D';
	END CASE;
END $

CALL test_case(55) $

#3.if结构
/*
注意：不是if函数。

功能：实现多重分支。

语法：
	if 条件1 then 语句1;
	elseif 条件2 then语句2;
	...
	【else 语句n;】
	end if;

应用：在begin end中。

*/

#案例：根据传入的成绩，来显示等级，比如传入的成绩：90-100，返回A，80-90，返回B，60-80，返回C，否则返回D。
CREATE FUNCTION test_if(score INT) RETURNS CHAR
BEGIN
	IF score>=90 AND score<=100 THEN RETURN 'A';
	ELSEIF score>=80 THEN RETURN 'B';
	ELSEIF score>=60 THEN RETURN 'C';
	ELSE RETURN 'D';
	END IF;
END $

SELECT test_if(86) $


#二、循环结构
/*

分类：while、loop、repeat

循环控制：
    （1）iterate类似于continue，继续，结束本次循环，继续下一次
    （2）leave类似于break，跳出，结束当前所在的循环
    
注意：要想使用循环控制，必须加标签。

应用：在begin end中。

*/

#1.while
/*

语法：
	【标签:】while 循环条件 do
		循环体;
	end while【标签】;

联想：
	while(循环条件) {
	    循环体;
	}

*/

#2.loop
/*

语法：
	【标签:】loop
		循环体;
	end loop【标签】;

应用：可以用来模拟简单的死循环。

*/

#3.repeat
/*

语法：
	【标签:】repeat
		循环体;
	until 结束循环的条件
	end repeat【标签】;

*/

#1.没有添加循环控制语句

#案例：批量插入，根据次数插入到admin表中多条记录
USE girls $

TRUNCATE TABLE admin $

DROP PROCEDURE test_while1 $

CREATE PROCEDURE test_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	WHILE i<=insertCount DO
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Rose',i),'666');
		SET i=i+1;
	END WHILE;
END $

CALL test_while1(100) $

SELECT * FROM admin $


#2.添加leave语句

#案例：批量插入，根据次数插入到admin表中多条记录，如果次数>20则停止。
TRUNCATE TABLE admin $

DROP PROCEDURE test_while1 $

CREATE PROCEDURE test_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	a:WHILE i<=insertCount DO
		INSERT INTO admin(username,`password`) VALUES(CONCAT('xiaohua',i),'0000');
		IF i>=20 THEN LEAVE a;
		END IF;
		SET i = i + 1;
	END WHILE a;
END $

CALL test_while1(30) $

SELECT * FROM admin $

#3.添加iterate语句

#案例：批量插入，根据次数插入到admin表中多条记录，只插入偶数次
TRUNCATE TABLE admin $

DROP PROCEDURE test_while1 $

CREATE PROCEDURE test_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	a:WHILE i<=insertCount DO
		SET i = i + 1;
		IF MOD(i,2) != 0 THEN ITERATE a;
		END IF;
		INSERT INTO admin(username,`password`) VALUES(CONCAT('xiaohua',i),'0000');
	END WHILE a;
END $

CALL test_while1(30) $

SELECT * FROM admin $


#案例讲解【流程控制】

#1.已知表stringcontent
/*
其中字段：
    （1）id 自增长
    （2）content varchar(20)

向改表插入指定个数的随机的字符串。

*/

DROP TABLE IF EXISTS stringcontent $

CREATE TABLE stringcontent (
	id INT PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(20)

) $

CREATE PROCEDURE test_randstr_insert(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1; #定义一个循环变量i，表示插入次数
	DECLARE str VARCHAR(26) DEFAULT 'abcdefghigklmopqrstuvwxyz';
	DECLARE startIndex INT DEFAULT 1; #代表起始索引
	DECLARE len INT DEFAULT 1; #代表截取的字符的长度
	WHILE i<=insertCount DO
		SET len = FLOOR(RAND()*(20-startIndex+1)+1); #产生一个随机的整数，代表截取的长度：1-(26-startIndex)
		SET startIndex = FLOOR(RAND()*26 + 1); #产生一个随机的整数，代表起始索引1-26
		INSERT INTO stringcontent(content) VALUES(SUBSTR(str,startIndex));
		SET i=i+1; #循环变量更新
	END WHILE;
END $

CALL test_randstr_insert(10) $

SELECT * FROM stringcontent $
















