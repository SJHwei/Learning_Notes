#进阶1: 基础查询
/*
语法: select 查询列表 from 表名;
类似于: System.out.println(打印东西)
特点: 
    1.查询列表可以是: 表中的字段, 常量值, 表达式, 函数.
    2.查询的结果是一个虚拟的表格.
*/

#打开要使用的库
USE myemployees;

#1.查询表中的单个字段
SELECT last_name FROM employees;
#2.查询表中的多个字段
SELECT last_name, salary, email FROM employees;
#3.查询表中的所有字段
#方式一: (注意: 字段上加的``是着重号, 可以去掉, 但是有时字段名是关键字, 所以需要加上着重号标识这是个字段而不是关键字.)
SELECT `employee_id`,`first_name`,`last_name`,`email`,`phone_number`,`job_id`,`salary`,`commission_pct`,`manager_id`,`department_id`,`hiredate` FROM employees;
#方式二:
SELECT * FROM employees;
#注意: 要执行哪条语句就选中哪条语句, 或者把光标放到哪条语句上.

#4.查询常量值
SELECT 100;
SELECT 'join';

#5.查询表达式
SELECT 100%98;

#6.查询函数
SELECT VERSION();

#7.起别名(给字段)
/*
(1) 便于理解;
(2) 如果要查询的字段有重名的情况, 使用别名可以区分开来.
*/
#方式一: 使用as
SELECT 100%98 AS 结果;
SELECT last_name AS 姓, first_name AS 名 FROM employees;
#方式二: 使用空格
SELECT last_name 姓, first_name 名 FROM employees;

#案例: 查询salary, 显示结果为out put
#注意: 如果别名和关键字冲突, 则给别名加上""或者'', 推荐双引号.
SELECT salary AS "out put" FROM employees;