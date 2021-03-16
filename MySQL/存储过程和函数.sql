#存储过程和函数
/*

存储过程和函数：类似于java中的方法

好处：
    1.提高代码的重用性；
    2.简化操作。

*/


#存储过程
/*

含义：一组预先编译好的sql语句的集合，理解成批处理语句。

好处：
    1.提高代码重用性；
    2.简化操作；
    3.减少了编译次数并且和数据库服务器的连接次数，提高了效率。

*/

#一、创建语法
/*
语法：
    create procedure 存储过程名(参数列表)
    begin
	存储过程体(一组合法的sql语句)
    end
 
注意：
    1.参数列表包含三部分：参数模式 参数名 参数类型。举例：in stuname varchar(20)；
    2.参数模式：
        （1）in：该参数可以作为输入，也就是该参数需要调用方传值；
        （2）out：该参数可以作为输出，也就是该参数可以作为返回值；
        （3）inout：该参数既可以作为输入又可以作为输出，也就是该参数既需要传入值，又可以返回值。
    3.如果存储过程体仅仅只有一句话，begin end可以省略。
      存储过程体中的每条sql语句的结尾要求必须加分号。
      存储过程的结尾可以使用delimiter重新设置。
      语法：delimiter 结束标记。
      案例：delimiter $
    

*/

#二、调用语法
/*

call 存储过程名(实参列表);

*/

#1.空参列表
#案例：插入到admin表中五条记录

USE girls;

SELECT * FROM admin;

DELIMITER $

#创建
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO admin(username,`password`)
	VALUES('john1','0000'),('lily','0000'),('rose','0000'),('jack','0000'),('tom','0000');
END $

#调用
CALL myp1()$

#2.创建带in模式参数的存储过程
#案例1：创建存储过程实现：根据女神名，查询对应的男神信息

#创建
CREATE PROCEDURE myp2(IN beautyName VARCHAR(20))
BEGIN
	SELECT bo.*
	FROM boys bo
	RIGHT JOIN beauty b ON bo.id = b.boyfriend_id
	WHERE b.name = beautyName;
END $

#调用
CALL myp2('柳岩')$

#案例2：创建存储过程实现：用户是否登录成功

#创建
CREATE PROCEDURE myp3(IN username VARCHAR(20),IN PASSWORD VARCHAR(20))
BEGIN
	DECLARE result INT DEFAULT 0; #声明并初始化
	
	SELECT COUNT(*) INTO result #赋值
	FROM admin
	WHERE admin.`username`=username
	AND admin.`password`=PASSWORD;
	
	SELECT IF(result>0,'成功','失败'); #使用
END $

#调用
CALL myp3('张飞','8888')$

#3.创建带out模式的存储过程
#案例1：根据女神名，返回对应的男神名

#创建
CREATE PROCEDURE myp4(IN beautyName VARCHAR(20),OUT boyName VARCHAR(20))
BEGIN
	SELECT bo.boyName INTO boyName
	FROM boys bo
	INNER JOIN beauty b ON bo.id = b.boyfriend_id
	WHERE b.name = beautyName;
END $

#调用
CALL myp4('小昭',@bName) $
SELECT @bName $

#案例2：根据女神名，返回对应的男神名和男神魅力值

#创建
CREATE PROCEDURE myp5(IN beautyName VARCHAR(20),OUT boyName VARCHAR(20),OUT userCP INT)
BEGIN
	SELECT bo.boyName,bo.userCP INTO boyName,userCP
	FROM boys bo
	INNER JOIN beauty b ON bo.id = b.boyfriend_id
	WHERE b.name = beautyName;
END $

#调用
CALL myp5('小昭',@bName,@usercp) $
SELECT @bName,@usercp $

#4.创建带inout模式参数的存储过程
#案例1：传入a和b两个值，最终a和b都翻倍并返回

#创建
CREATE PROCEDURE myp6(INOUT a INT,INOUT b INT)
BEGIN
	SET a=a*2;
	SET b=b*2;
END$

#调用
SET @m=10$
SET @n=20$
CALL myp6(@m,@n)$
SELECT @m,@n$


#案例讲解【存储过程】

#1.创建存储过程或函数实现传入用户名和密码，插入到admin表中
CREATE PROCEDURE myp7(IN username VARCHAR(20),IN PASSWORD VARCHAR(20))
BEGIN
	INSERT INTO admin(admin.username,admin.password)
	VALUES(username,PASSWORD);
END$

CALL myp7('hahaha','1111')$

SELECT * FROM admin $
#2.创建存储过程或函数实现传入女神编号，返回女神名称和女神电话
CREATE PROCEDURE myp8(IN beautyId INT,OUT beautyName VARCHAR(20),OUT beautyNumber VARCHAR(20))
BEGIN
	SELECT NAME,phone INTO beautyName,beautyNumber
	FROM beauty
	WHERE id=beautyId;
END$

CALL myp8(1,@beautyName,@beautyNumber)$

SELECT @beautyName,@beautyNumber$
#3.创建存储过程或函数实现传入两个女神生日，返回大小
CREATE PROCEDURE myp9(IN birth1 DATETIME,IN birth2 DATETIME,OUT result INT)
BEGIN
	SELECT DATEDIFF(birth1,birth2) INTO result;
END$

CALL myp9('1998-1-1',NOW(),@result)$

SELECT @result$


#三、删除存储过程
#语法：drop procedure 存储过程名;
DROP PROCEDURE myp9 $
#drop procedure myp8,myp7; #错误，只能一次删一个


#四、查看存储过程的信息
#desc myp2; #错误
SHOW CREATE PROCEDURE myp2 $


#案例讲解2【存储过程】

#1.创建存储过程或函数实现传入一个日期，格式化成xx年xx月xx日并返回
CREATE PROCEDURE test_pro1(IN mydate DATETIME,OUT strDate VARCHAR(50))
BEGIN
	SELECT DATE_FORMAT(mydate,'%y年%m月%d日') INTO strDate;
END $

CALL test_pro1(NOW(),@str)$

SELECT @str $
#2.创建存储过程或函数实现传入女神名称，返回 女神and男神 格式化的字符串。如传入小昭，返回小昭and张无忌
CREATE PROCEDURE test_pro2(IN beautyName VARCHAR(20),OUT str VARCHAR(50))
BEGIN
	SELECT CONCAT(beautyName,' and ',IFNULL(boyName,'null'))
	FROM boys bo
	RIGHT JOIN beauty b ON b.boyfriend_id = bo.id
	WHERE b.name=beautyName;
END$

CALL test_pro2('小昭',@str)$

SELECT @str$
#3.创建存储过程或函数，根据传入的条目数和起始索引，查询beauty表的记录
CREATE PROCEDURE test_pro3(IN startIndex INT,IN size INT)
BEGIN
	SELECT * FROM beauty LIMIT startIndex,size;
END $

CALL test_pro3(3,5)$


#函数
/*

含义：一组预先编译好的SQL语句的集合，理解成批处理语句。

作用：
    （1）提高代码的重用性；
    （2）简化操作；
    （3）减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率。
    
函数和存储过程的区别：
    （1）存储过程：可以有0个返回，也可以有多个返回，适合做批量插入，批量更新；
    （2）函数：有且仅有1个返回，适合做处理数据后返回一个结果。

*/

#一、创建语法
/*
语法：
	create function 函数名(参数列表) returns 返回类型 
	begin 
		函数体
	end

注意：
    （1）参数列表包含两个部分：参数名 参数类型；
    （2）函数体：肯定会有return语句，如果没有会报错，如果return语句没有放在函数体的最后也不报错，但不建议，return 值；
    （3）函数体中仅有一句话，则可以省略begin end；
    （4）使用delimiter语句设置结束标记。

*/

#二、调用语法
/*
语法：select 函数名(参数列表) 

*/

#--------------------------案例演示---------------------------------

#1.无参有返回

#案例：返回公司的员工个数
CREATE FUNCTION myf1() RETURNS INT
BEGIN
	DECLARE c INT DEFAULT 0; #定义局部变量
	SELECT COUNT(*) INTO c #赋值
	FROM employees;
	
	RETURN c;
END $

SELECT myf1()$

#2.有参有返回

#案例1：根据员工名，返回他的工资
CREATE FUNCTION myf2(empName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	SET @sal=0; #定义用户变量
	SELECT salary INTO @sal #赋值
	FROM employees
	WHERE last_name = empName;
	
	RETURN @sal;
END $

SELECT myf2('Kochar') $

#案例2：根据部门名，返回该部门的平均工资
CREATE FUNCTION myf3(deptName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	DECLARE sal DOUBLE;
	SELECT AVG(salary) INTO sal
	FROM employees e
	JOIN departments d ON e.department_id = d.department_id
	WHERE d.department_name = deptName;
	
	RETURN sal;
END $

SELECT myf3('IT') $

#三、查看函数 
/*

语法：show create function myf3;

*/

#四、删除函数
/*

语法：drop function myf3;

*/


#案例讲解【函数】

#一、创建函数，实现传入两个float，返回二者之和
CREATE FUNCTION test_fun1(num1 FLOAT,num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE SUM FLOAT DEFAULT 0;
	SET SUM = num1 + num2;
	RETURN SUM;
END $

SELECT test_fun1(1,2)$