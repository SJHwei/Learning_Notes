#DML语言
/*
数据操作语言:
    插入: insert
    修改: update
    删除: delete
*/


#一. 插入语句

#方式一: 经典的插入
/*
语法: insert into 表名(列名,...) values(值1,...);

*/

SELECT * FROM beauty;

#1. 插入的值的类型要与列的类型一致或兼容
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','189888888',NULL,2);

#2. 不可以为null的列必须插入值. 可以为null的列如何插入值?
#方式一:
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','189888888',NULL,2);
#方式二:
INSERT INTO beauty(id,NAME,sex,borndate,phone,boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','189888888',2);

#3. 列的顺序可以调换
INSERT INTO beauty(NAME,sex,id,phone)
VALUES('蒋欣','女',16,'110');

#4. 列数和值的个数必须一致
INSERT INTO beauty(NAME,sex,id,phone)
VALUES('关晓彤','女',17,'110');

#5. 可以省略列名, 默认所有列, 而且列的顺序和表中列的顺序一致
INSERT INTO beauty 
VALUES(18,'张飞','男',NULL,'119',NULL,NULL);

#方式二:
/*
语法: insert into 表名 set 列名=值, 列名=值, ...

*/

INSERT INTO beauty
SET id=19, NAME='刘涛', phone='999';

#两种方式大PK

#1. 方式一支持插入多行, 方式二不支持
INSERT INTO beauty
VALUES(23,'唐艺昕','女','1990-4-23','189888888',NULL,2),
(24,'唐艺昕','女','1990-4-23','189888888',NULL,2),
(25,'唐艺昕','女','1990-4-23','189888888',NULL,2);

#2. 方式一支持子查询, 方式二不支持
INSERT INTO beauty(id, NAME, phone)
SELECT 26, '宋茜', '11809866';

INSERT INTO beauty(id, NAME, phone)
SELECT id, boyname, '11809866'
FROM boys WHERE id < 3;


#二. 修改语句
/*
1. 修改单表的记录★

语法: update 表名 set 列=新值, ... where 筛选条件;

2. 修改多表的记录[补充]

语法:
    (1)sql92语法: update 表1 别名, 表2 别名 set 列=值, ... where 连接条件 sand 筛选条件;
    (2)sql99语法: update 表1 别名 inner|left|right join 表2 别名 on 连接条件 set 列=值, ... where 筛选条件;

*/

#1. 修改单表的记录

#案例1: 修改beauty表中姓唐的女神的电话为13899888899
UPDATE beauty SET phone = '13899888899'
WHERE NAME LIKE '唐%';

#案例2: 修改boys表中id号为2的名称为张飞, 魅力值为10
UPDATE boys SET boyname = '张飞', usercp = 10
WHERE id = 2;

#2. 修改多表的记录

#案例1: 修改张无忌的女朋友的手机号为114
UPDATE beauty be
JOIN boys bo
ON be.`boyfriend_id`=bo.`id`
SET photo = '114'
WHERE bo.`boyName`='张无忌';

#案例2: 修改没有男朋友的女神的男朋友编号都为2号
UPDATE boys bo
RIGHT JOIN beauty be ON bo.`id` = be.`boyfriend_id`
SET be.`boyfriend_id` = 2
WHERE bo.`id` IS NULL;


#三. 删除语句
/*
方式一: delete
语法: 
    (1) 单表的删除★: delete from 表名 where 筛选条件;
    (2) 多表的删除[补充]:
            1> sql92语法: delete 表1的别名, 表2的别名 from 表1 别名, 表2 别名 where 连接条件 and 筛选条件;
            2> sql99语法: delete 表1的别名, 表2的别名 from 表1 别名 inner|left|right join 表2 别名 on 连接条件 where 筛选条件;

方式二: truncate
语法: truncate table 表名;

*/

#方式一: delete

#1. 单表的删除

#案例: 删除手机号以9结尾的女神信息
DELETE FROM beauty WHERE phone LIKE '%9';

#2. 多表的删除

#案例1: 删除张无忌的女朋友的信息
DELETE b FROM beauty b 
INNER JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName` = '张无忌';

#案例2: 删除黄晓明的信息以及他女朋友的信息
DELETE b, bo FROM beauty b
INNER JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName` = '黄晓明';

#方式二: truncate语句

#案例: 删除男神表
TRUNCATE TABLE boys;

#delete PK truncate[面试题]
/*
1. delete可以加where条件, truncate不能加

2. truncate删除, 效率高一丢丢

3. 如果要删除的表中有自增长列:
    如果使用delete删除后, 再插入数据, 自增长列的值从断点开始,
    而truncate删除后, 再插入数据, 自增长列的值从1开始.
    
4. truncate删除没有返回值, delete删除有返回值.

5. truncate删除不能回滚, delete删除可以回滚.
*/


#数据的增删改[案例讲解]

#1. 运行一下脚本创建表my_employees
USER myemployees;
CREATE TABLE my_employees(

	Id INT(10),
	First_name VARCHAR(10),
	Last_name VARCHAR(10),
	Userid VARCHAR(10),
	Salary DOUBLE(10, 2)

);
CREATE TABLE users(

	id INT,
	userid VARCHAR(10),
	department_id INT

)

#2. 显示表my_employees的结构
DESC my_employees;

#3. 向my_employees表中插入下列数据
# ID    FIRST_NAME    LAST_NAME    USERID    SALARY
# 1     patel         Ralph        Rpatel    895
# 2     Dancs         Betty        Bdancs    860
# 3     Biri          Ben          Bbiri     1100
# 4     Newman        Chad         Cnewman   750
# 5     Ropeburn      Audrey       Aropebur  1550
#方式一: 使用上面刚学到的insert语句
#方式二: 使用联合查询
INSERT INTO my_employees
SELECT 1,'patel','Ralph','Rpatel',895 UNION
SELECT 2,'Dancs','Betty','Bdancs',860;

#4. 向users表中插入数据
# 1     Rpatel        10
# 2     Bdancs        10
# 3     Bbiri         20
# 4     Cnewman       30
# 5     Aropebur      40

#5. 将3号员工的last_name修改为"drelxer"
UPDATE my_employees SET last_name='drelxer' WHERE id = 3;

#6. 将所有工资少于900的员工的工资修改为1000
UPDATE my_employees SET salary = 1000 WHERE salary < 900;

#7. 将userid为Bbiri的USER表和my_employees表的记录全部删除
DELETE u,e
FROM users u
JOIN my_employees e ON u.`userid` = e.`Userid`
WHERE u.`userid` = 'Bbiri';

#8. 删除所有数据
DELETE FROM my_employees;
DELETE FROM users;

#9. 检查所做的修正

#10. 清空表my_employees
TRUNCATE TABLE my_employees;
TRUNCATE TABLE users;
