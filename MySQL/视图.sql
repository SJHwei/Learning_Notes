#视图
/*

含义: 
    (1) (概述版)虚拟表, 和普通表一样使用. mysql5.1版本出现的新特性, 是通过表动态生成的数据.
    (2) (具体版)一种虚拟存在的表, 行和列的数据来自定义视图的查询中使用的表, 并且是在使用视图时动态生成的, 只保存了SQL逻辑, 不保存查询结果.

区别: 类似于舞蹈班和普通班的区别, 舞蹈班是为应付领导视察临时组件的, 该班内学生还是属于原普通班的.

应用场景:
    (1) 多个地方用到同样的查询结果;
    (2) 该查询结果使用的sql语句较复杂.
    
示例: 
    create view my_v1
    as
    select studentname,majorname
    from students
    inner join major m
    on s.majorid=m.majorid
    where s.majorid=1;
    
视图和表的对比：
		创建语法的关键字       是否实际占用物理空间         使用
	视图       create view          只是保存了SQL逻辑         增删改查，一般不能增删改
	表        create table            保存了数据              增删改查

*/


#案例: 查询姓张的学生名和专业名

USE students;

#原方式
SELECT stuname, majorname
FROM stuinfo s
INNER JOIN major m ON s.`majorid`=m.`id`
WHERE s.`stuname` LIKE '张%';

#使用视图
CREATE VIEW v1
AS
SELECT stuname, majorname
FROM stuinfo s
INNER JOIN major m ON s.`majorid`=m.`id`;

SELECT * FROM v1 WHERE stuname LIKE '张%';


#一、创建视图
/*

语法： create view 视图名 as 查询语句;

视图的好处：
    （1）重用sql语句；
    （2）简化复杂的sql操作，不必知道它的查询细节；
    （3）保护数据，提高安全性。

*/

USE myemployees;

#1、查询姓名中包含a字符的员工名，部门名和工种信息
#①创建
CREATE VIEW myv1
AS
SELECT First_name, department_name, job_title
FROM employees e, departments d, jobs j
WHERE e.department_id=d.`department_id` AND
e.job_id=j.job_id;
#②使用
SELECT * FROM myv1 WHERE First_name LIKE '%a%';
#2、查询各部门的平均工资级别
#①创建视图查看每个部门的平均工资
CREATE VIEW myv2
AS
SELECT AVG(salary) ag, department_id
FROM employees
GROUP BY department_id;
#②使用
SELECT myv2.`ag`, g.grade_level
FROM myv2
JOIN job_grades g ON myv2.`ag` BETWEEN g.`lowest_sal` AND g.`highest_sal`;
#3、查询平均工资最低的部门信息
SELECT * FROM myv2 ORDER BY ag LIMIT 1;
#4、查询平均工资最低的部门名和工资
#①创建视图
CREATE VIEW myv3
AS
SELECT * FROM myv2 ORDER BY ag LIMIT 1;
#②使用
SELECT d.*, m.ag
FROM myv3 m
JOIN departments d ON m.`department_id`=d.`department_id`;


#二、视图的修改
/*

方式一：create or replace view 视图名 as 查询语句;

方式二：alter view 视图名 as 查询语句;

*/

#方式一案例
CREATE OR REPLACE VIEW myv3
AS
SELECT AVG(salary), job_id
FROM employees
GROUP BY job_id;
SELECT * FROM myv3;

#方式二案例
ALTER VIEW myv3 
AS
SELECT * FROM employees;


#三、删除视图
/*

语法：drop view  视图名, 视图名, ...;

*/

DROP VIEW myv1,myv2,myv3;


#四、查看视图

DESC myv3;

SHOW CREATE VIEW myv3;


#案例讲解【视图的创建】

#1、创建视图emp_v1，要求查询电话号码以'011'开头的员工姓名和工资，邮箱
CREATE VIEW emp_v1
AS
SELECT first_name, salary, email
FROM employees
WHERE phone_number LIKE '011%';
#2、创建视图emp_v2，要求查询部门的最高工资高于12000的部门信息
#原方式
SELECT d.*, m.mx_dep
FROM departments d
JOIN (
	SELECT MAX(salary) mx_dep, department_id
	FROM employees
	GROUP BY department_id
	HAVING MAX(salary) > 12000

) m
ON m.department_id = d.`department_id`;
#视图方式
CREATE OR REPLACE VIEW emp_v2
AS
SELECT MAX(salary) mx_dep, department_id
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 12000;

SELECT d.*,m.mx_dep
FROM departments d
JOIN emp_v2 m
ON m.department_id = d.`department_id`;


#五、视图的更新

DROP VIEW myv1,myv2,myv3;

CREATE OR REPLACE VIEW myv1
AS 
SELECT last_name,email,salary*12*(1+IFNULL(commission_pct,0)) "annual salary"
FROM employees;

CREATE OR REPLACE VIEW myv1
AS
SELECT last_name, email
FROM employees;

SELECT * FROM myv1;
SELECT * FROM employees;

#注意：以下三个操作是对简单视图进行更新，同时可以对表进行更新，这样不安全，所以往往会为视图添加权限，权限是只允许读，不能更新。
#注意：视图的可更新性和视图中查询的定义有关系，以下类型的视图是不能更新的。
/*
（1）包含以下关键字的sql语句：分组函数，distinct，group by，having，union或者union all
（2）常量视图
（3）select中包含子查询
（4）join
（5）from一个不能更新的视图
（6）where子句的子查询引用了from子句中的表
*/

#1.插入

INSERT INTO myv1 VALUES('张飞','zf@qq.com');

#2.修改

UPDATE myv1 SET last_name = '张无忌' WHERE last_name = '张飞';

#3.删除

DELETE FROM myv1 WHERE last_name = '张无忌';

#具备以下特点的视图是不允许更新的：
/*
（1）包含以下关键字的sql语句：分组函数，distinct，group by，having，union或者union all
（2）常量视图
（3）select中包含子查询
（4）join
（5）from一个不能更新的视图
（6）where子句的子查询引用了from子句中的表
*/


#测试题讲解

#1.创建book表，字段如下:
/*
    bid 整型, 要求主键
    bname 字符型, 要求设置唯一键, 并非空
    price 浮点型, 要求有默认值10
    btypeId 类型编号, 要求引用bookType表的id字段
*/
USE books;

DROP TABLE IF EXISTS book;

CREATE TABLE book(
	bid INT PRIMARY KEY,
	bname VARCHAR(30) UNIQUE NOT NULL,
	price DOUBLE DEFAULT 10,
	typeId INT,
	
	FOREIGN KEY(typeId) REFERENCES bookType(id)

);

ALTER TABLE book MODIFY COLUMN price FLOAT;

DROP TABLE bookType;

CREATE TABLE bookType(
	id INT PRIMARY KEY,
	`name` VARCHAR(30)

);
#2.开启事务, 向表中插入一行数据, 并结束
SET autocommit=0;
START TRANSACTION;
INSERT INTO bookType VALUES(46, '计算机');
INSERT INTO book VALUES(1,'数据结构',100,46);
INSERT INTO book VALUES(2,'机组',110,46);
COMMIT;
#3.创建视图, 实现查询价格大于100的书名和类型名
CREATE OR REPLACE VIEW myv11
AS
SELECT bname,`name`
FROM book b
JOIN bookType t ON b.typeId = t.id
WHERE price > 100;

SELECT * FROM myv11;
#4.修改视图, 实现查询价格在90-120之间的书名和价格
CREATE OR REPLACE VIEW myv11 
AS
SELECT bname,price
FROM book;

SELECT bname,price
FROM myv11
WHERE price BETWEEN 90 AND 120;
#5.删除刚才建的视图
DROP VIEW myv11;





