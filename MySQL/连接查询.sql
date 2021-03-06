#进阶6: 连接查询
/*
含义: 又称多表查询, 当查询的字段来自于多个表时, 就会用到连接查询

笛卡尔乘积现象: 表一有m行, 表二有n行, 结果=m*n行.

发生原因: 没有有效的连接条件.

如何避免: 添加有效的连接条件.

分类:
(1)按年代分类:
        1> sql92标准:仅仅支持内连接
        2> sql99标准(推荐):支持内连接+外连接(左外+右外)+交叉连接
(2)按功能分类:
        1> 内连接:
                等值连接
                非等值连接
                自连接
        2> 外连接:
                左外连接
                右外连接
                全外连接
        3> 交叉连接
*/

SELECT * FROM beauty;
SELECT * FROM boys;
SELECT `name`, boyName FROM boys, beauty; #错误结果

SELECT `name`, boyName FROM boys, beauty
WHERE beauty.`boyfriend_id`=boys.`id`; #正确结果


#一. sql192标准

#1. 等值连接
/*
(1) 多表等值连接的结果为多表的交集部分
(2) n表连接至少需要n-1个连接条件
(3) 多表的顺序没有要求
(4) 一般需要为表起别名
(5) 可以搭配前面介绍的所有子句使用, 比如排序, 分组, 筛选
*/

#案例1: 查询女神名和对应的男神名
SELECT `name`, boyName 
FROM boys, beauty
WHERE beauty.`boyfriend_id`=boys.`id`;
#案例2: 查询员工名和对应的部门名
SELECT last_name, department_name
FROM employees, departments
WHERE employees.`department_id`=departments.`department_id`;

#2. 为表起别名
/*
好处:
(1) 提高语句的简洁度
(2) 区分多个重名的字段

注意: 如果为表起了别名, 则查询的字段就不能使用原来的表名去限定.
*/

#案例1: 查询员工名, 工种号, 工种名
SELECT last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.`job_id`=j.`job_id`;

#3. 两个表的顺序可以调换

#案例1: 查询员工名, 工种号, 工种名
SELECT e.last_name, e.job_id, job_title
FROM jobs j, employees e
WHERE e.`job_id`=j.`job_id`;

#4. 可以加筛选

#案例1: 查询有奖金的员工名, 部门名
SELECT last_name, department_name, commission_pct
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
AND e.`commission_pct` IS NOT NULL;
#案例2: 查询城市名中第二个字符为o的部门名和城市名
SELECT department_name, city
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
AND city LIKE '_o%';

#5. 可以加分组

#案例1: 查询每个城市的部门个数
SELECT COUNT(*) 个数, city
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
GROUP BY city;
#案例2: 查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT department_name, e.manager_id, MIN(salary)
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
AND e.`commission_pct` IS NOT NULL
GROUP BY department_name, e.`manager_id`;

#6. 可以加排序

#案例: 查询每个工种名和员工的个数, 并且按员工个数降序
SELECT job_title, COUNT(*) 个数
FROM employees e, jobs j
WHERE e.`job_id` = j.`job_id`
GROUP BY job_title
ORDER BY 个数 DESC;

#7. 可以实现三表连接

#案例: 查询员工名, 部门名和所在的城市
SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id` 
AND d.`location_id` = l.`location_id`;


CREATE TABLE job_grades
(grade_level VARCHAR(3),
lowest_sal INT,
highest_sal INT);

INSERT INTO job_grades
VALUES('A', 1000, 2999);

INSERT INTO job_grades
VALUES('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 1000O, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);

SELECT * FROM job_grades;


#2. 非等值连接
/*
和等值连接的特点基本上一样, 只有一点不一样, 就是连接条件不是等于号.
*/

#案例1: 查询员工的工资和工资级别
SELECT salary, grade_level
FROM employees e, job_grades g
WHERE salary BETWEEN g.`lowest_sal` AND g.`highest_sal`;


#3. 自连接
/*
相当于等值连接, 只不过是自己连接自己.
*/

#案例: 查询员工名和上级的名称
SELECT e.employee_id, e.last_name, m.`employee_id`, m.`last_name`
FROM employees e, employees m
WHERE e.`manager_id` = m.`employee_id`;


#测试题

#1. 显示员工表的最大工资, 工资平均值
SELECT MAX(salary), AVG(salary) FROM employees;
#2. 查询员工表的employee_id, job_id, last_name, 按department_id降序, salary升序.
SELECT employee_id, job_id, last_name FROM employees
ORDER BY department_id DESC, salary ASC;
#3. 查询员工表的job_id中包含a和e的, 并且a在e的前面.
SELECT job_id FROM employees WHERE job_id LIKE '%a%e%';
#4. 已知表student里面有id(学号), name, gradeId(年级编号)
#   已知表grade里面有id(年级编号), name(年级名)
#   已知表result里面有id, score, studentNo(学号)
#要求查询姓名, 年级名, 成绩
#select s.`name`, g.`name`, score from student s, grade g, result r
#where s.gradeId = g.id and s.id = r.studentNo;
#5. 显示当前日期, 以及去掉前后空格, 截取子字符串的函数
#select now();
#select trim(字符 from '');
#select substr(str, startIndex);
#select substr(str, startIndex, length);


#二. sql99语法
/*
语法:
    select 查询列表
    from 表1 别名 [连接类型]
    join 表2 别名 
    on 连接条件
    [where 筛选条件]
    [group by 分组]
    [having 筛选条件]
    [order by 排序列表]
    
注意: [连接类型]为下面三种.

内连接(重点): inner

外连接
    左外(重点): left [outer]
    右外(重点): right [outer]
    全外: full [outer]
    
交叉连接: cross
*/

#一) 内连接
/*
语法:
    select 查询列表
    from 表1 别名
    inner join 表2 别名
    on 连接条件

分类:
    等值连接
    非等值连接
    自连接
特点:
(1)添加排序, 分组, 筛选
(2)inner可以省略
(3)筛选条件放在where后面, 连接条件放在on后面, 提高分离性, 便于阅读
(4)inner join连接和sql92语法中的等值连接效果是一样的, 都是查询多表的交集


*/

#1. 等值连接

#案例1: 查询员工名, 部门名
SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`;
#案例2: 查询名字中包含e的员工名和工种名(添加筛选)
SELECT last_name, job_title
FROM employees e
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`
WHERE last_name LIKE '%e%';
#案例3: 查询部门个数大于3的城市名和部门个数(添加分组+筛选)
SELECT city, COUNT(*) 部门个数
FROM departments d
INNER JOIN locations l
ON d.`location_id` = l.`location_id`
GROUP BY city
HAVING 部门个数 > 3;
#案例4: 查询哪个部门的部门员工个数大于3的部门名和员工个数, 并按个数降序(排序)
SELECT department_name, COUNT(*) 员工个数
FROM departments d
INNER JOIN employees e
ON d.`department_id` = e.`department_id`
GROUP BY department_name
HAVING 员工个数 > 3
ORDER BY 员工个数 DESC;
#案例5: 查询员工名, 部门名, 工种名, 并按部门名降序(添加三表连接)
SELECT last_name, department_name, job_title
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`;
ORDER BY department_name DESC;

#2. 非等值连接

#案例1: 查询员工的工资级别
SELECT salary, grade_level
FROM employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`;
#案例2: 查询工资级别的个数>2的个数, 并且按工资级别降序
SELECT salary, grade_level, COUNT(*)
FROM employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY grade_level
HAVING COUNT(*) > 20
ORDER BY grade_level DESC;

#3. 自连接

#案例: 查询姓名中包含字符k的员工的名字, 上级的名字
SELECT e.last_name, m.last_name
FROM employees e
JOIN employees m
ON e.`manager_id` = m.`employee_id`
WHERE e.`last_name` LIKE '%k%';


#二) 外连接
/*
应用场景: 用于查询一个表中有, 另一个表中没有的记录

特点:
(1) 外连接的查询结果为主表中的所有记录.
    1> 如果从表中有和它匹配的, 则显示匹配的值;
    2> 如果从表中没有和它匹配的, 则显示null;
    3> 外连接查询结果 = 内连接结果+主表有而从表中没有的记录.
(2) 哪张表是主表, 哪张表是从表?
    1> 左外连接: left join, 左边的是主表;
    2> 右外连接: right join, 右边的是主表.
(3) 左外和右外交换两个表的顺序, 可以实现同样的效果.
(4) 全外连接 = 内连接的结果 + 表1中有但表2中没有的 + 表2中有但表1中没有.
*/

UPDATE boys SET usercp = NULL WHERE id = 3;

#案例1: 查询男朋友不在男神表的女神名
#左外连接
SELECT b.name, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;
#右外连接
SELECT b.name, bo.*
FROM boys bo
RIGHT OUTER JOIN beauty b
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;
#注意: 如果没有使用分组, 要在结果表上增加条件, 使用where即可, 不用使用having.
#注意: 为null的条件用id, 因为它是主键, 如果选用其他的, 则可能得到不符合要求的结果.

#案例2: 查询哪个部门没有员工
#左外连接
SELECT d.*, e.`employee_id`
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;
#右外连接
SELECT d.*, e.`employee_id`
FROM employees e
RIGHT OUTER JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;


#三) 全外连接

SELECT b.*, bo.*
FROM beauty b
FULL OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.id;


#四) 交叉连接

SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;


#sql92和sql99 PK
/*
(1)功能: sql99支持的较多
(2)可读性: sql99实现连接条件和筛选条件的分离, 可读性高
*/


#案例讲解[多表连接]
#1. 查询编号>3的女神的男朋友信息, 如果有则列出详情, 如果没有则用null填充.
SELECT b.`name`, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE b.`id` > 3;
#2. 查询哪个城市没有部门.
SELECT l.`city`, d.*
FROM locations l
LEFT OUTER JOIN departments d
ON l.`location_id` = d.`location_id`
WHERE d.`department_id` IS NULL;
#3. 查询部门名为sal或IT的员工信息.
SELECT d.`department_name`, e.*
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name` IN ('SAL','IT');



