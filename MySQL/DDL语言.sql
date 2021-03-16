#DDL
/*
DDL(数据定义语言): 库和表的管理

一. 库的管理: 创建, 修改, 删除

二. 表的管理: 创建, 修改, 删除

创建: create
修改: alter
删除: drop
*/


#一. 库的管理

#1. 库的创建
/*
语法: create database [if not exists] 库名;
*/

#案例: 创建库Books
CREATE DATABASE IF NOT EXISTS books;

#2. 库的修改

#案例: 修改库的字符集
ALTER DATABASE books CHARACTER SET gdk;

#3. 库的删除

DROP DATABASE IF EXISTS books;


#二. 表的管理

#1. 表的创建★
/*
语法:
        create table 表名(

		列名 列的类型[(长度) 约束],
		列名 列的类型[(长度) 约束],
		列名 列的类型[(长度) 约束],
		...
		列名 列的类型[(长度) 约束]
	
        );
*/

#案例1: 创建表Book
CREATE TABLE book(

	id INT, #编号
	bName VARCHAR(20), #图书名
	price DOUBLE, #价格
	authorId INT, #作者编号
	publishDate DATETIME #出版日期

);

DESC book;

#案例2: 创建表author
CREATE TABLE author(

	id INT`books``books`,
	au_name VARCHAR(20),
	nation VARCHAR(10)

);

DESC author;

#2. 表的修改
/*
语法: alter table 表名 change|modify|add|drop column 列名 [列类型 约束];
*/

#①修改列名: change (alter table 表名 change [column] 旧列名 新列名 新列名类型;) 
ALTER TABLE book CHANGE COLUMN publishdate pubDate DATETIME;

#②修改列的类型或约束: modify
ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;

#③添加新列: add
ALTER TABLE author ADD COLUMN annual DOUBLE;

#④删除列: drop
ALTER TABLE author DROP COLUMN annual;

#⑤修改表名: rename to
ALTER TABLE author RENAME TO book_author;

#3. 表的删除

DROP TABLE IF EXISTS book_author;

SHOW TABLES;

#通用的写法:
/*

DROP DATABASE IF EXISTS 旧库名;
CREATE DATABASE 新库名;

DROP TABLE IF EXISTS 旧表名;
CREATE TABLE 表名();

*/

#4. 表的复制

INSERT INTO author VALUES
(1,'村上春树','日本'),
(2,'莫言','中国'),
(3,'冯唐','中国')
(4,'金庸','中国');

#(1) 仅仅复制表的结构

CREATE TABLE copy LIKE author;

#(2) 复制表的结构+数据
CREATE TABLE copy2
SELECT * FROM author;

SELECT * FROM copy2;

#只复制部分数据
CREATE TABLE copy3
SELECT id, au_name
FROM author 
WHERE nation = '中国';

#仅仅复制某些字段
CREATE TABLE copy4
SELECT id, au_name
FROM author
WHERE 0;


#案例讲解[库和表的管理]

USE test;

#1. 创建dept1
CREATE TABLE dept1(

	id INT(7),
	`name` VARCHAR(25)

);
#2. 将表departments中的数据插入到新表dept2中
CREATE TABLE dept2
SELECT * FROM myemployees.departments;
#3. 创建emp5
CREATE TABLE emp5(

	id INT(7),
	First_name VARCHAR(25),
	Last_name VARCHAR(25),
	Dept_id INT(7)

);
#4. 将列Last_name的长度增加到50
ALTER TABLE emp5 MODIFY COLUMN last_name VARCHAR(50);
#5. 根据employees创建employees2
CREATE TABLE employees2 LIKE myemployees.employees;
#6. 删除表emp5
DROP TABLE IF EXISTS emp5;
#7. 将表employees2重命名为emp5
ALTER TABLE employees2 RENAME TO emp5;
#8. 在表dept和emp5中添加新列test_column, 并检查所作的操作
ALTER TABLE dept ADD COLUMN test_column INT;
ALTER TABLE emp5 ADD COLUMN test_column INT;
DESC dept;
DESC emp5;
#9. 直接删除表emp5中的列dept_id
ALTER TABLE emp5 DROP COLUMN dept_id;








