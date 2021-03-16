#进阶7: 子查询
/*
含义: 
    出现在其他语句中的select语句, 称为子查询或内查询;
    外部的查询语句, 称为主查询或外查询.
    
分类:
(1)按子查询出现的位置:
    1> select后面:
                仅仅支持标量子查询.
    2> from后面:
		支持表子查询.
    3> where或having后面(重点):
		标量子查询(重点)(单行);
		列子查询(重点)(多行);
		行子查询.
    4> exists后面(相关子查询):
		表子查询.
(2)按结果集的行列数不同:
    1> 标量子查询 (结果集只有一行一列)
    2> 列子查询 (结果集只有一列多行)
    3> 行子查询 (结果集中有一行多列)
    4> 表子查询 (结果集一般为多行多列)
*/


#一. where或having后面(重点)
#1. 标量子查询(单行子查询)(重点)
#2. 列子查询(多行子查询)(重点)
#3. 行子查询
/*
特点:
    (1) 子查询放在小括号内;
    (2) 子查询一般放在条件的右侧;
    (3) 标量子查询一般搭配着单行操作符使用: > < >= <= = <>;
    (4) 列子查询一般搭配着多行操作符使用: in/not in any/some all;
    (5) 子查询的执行优先于主查询执行, 主查询的条件用到了子查询的结果.
*/

#1. 标量子查询

#案例1: 谁的工资比Abel高?
#①查询Abel的工资
SELECT salary FROM employees WHERE last_name = 'Abel';
#②查询员工的信息, 满足salary>①结果
SELECT * FROM employees 
WHERE salary > (

    SELECT salary 
    FROM employees 
    WHERE last_name = 'Abel'

);
#案例2: 返回job_id与141号员工相同, salary比143号员工多的员工姓名, job_id和工资
#①查询143号员工的工资
SELECT salary FROM employees WHERE employee_id = 143;
#②查询141号员工的job_id
SELECT job_id FROM employees WHERE employee_id = 141;
#③查询job_id=②, salary>①的员工姓名, job_id和工资
SELECT last_name, job_id, salary FROM employees
WHERE job_id = (

    SELECT job_id 
    FROM employees 
    WHERE employee_id = 141

) AND salary > (

    SELECT salary 
    FROM employees 
    WHERE employee_id = 143

);
#案例3: 返回公司工资最少的员工的last_name, job_id和salary
#①查询公司的最低工资
SELECT MIN(salary) FROM employees;
#②查询工资=①的员工的last_name, job_id和salary
SELECT last_name, job_id, salary FROM employees
WHERE salary = (

    SELECT MIN(salary) 
    FROM employees

);
#案例4: 查询最低工资大于50号部门最低工资的部门id和其最低工资
#①查询50号部门的最低工资
SELECT MIN(salary) FROM employees WHERE department_id = 50;
#②查询最低工资>①的部门id和其最低工资
SELECT department_id, MIN(salary) 最低工资 FROM employees
GROUP BY department_id
HAVING 最低工资 > (

    SELECT MIN(salary) 
    FROM employees 
    WHERE department_id = 50

);
#案例5: 非法使用标量子查询
SELECT department_id, MIN(salary) 最低工资 FROM employees
GROUP BY department_id
HAVING 最低工资 > (

    SELECT salary
    FROM employees 
    WHERE department_id = 250

);

#2. 列子查询(多行子查询)
/*
(1) 返回多行.
(2) 使用多行比较操作符.
    1> IN/NOT IN: 等于或不等于列表中的任意一个;
    2> ANY|SOME: 和子查询返回的某一个值比较;
    3> ALL: 和子查询返回的所有值比较.
*/

#案例1: 返回location_id是1400或1700的部门中的所有员工姓名
#①查询location_id是1400或1700的部门编号
SELECT DISTINCT department_id FROM departments WHERE location_id IN (1400, 1700);
#②查询员工姓名, 要求部门号是①列表中的某一个
SELECT last_name FROM employees 
WHERE department_id IN (

	SELECT DISTINCT department_id 
	FROM departments 
	WHERE location_id IN (1400, 1700)

);
#或者
SELECT last_name FROM employees 
WHERE department_id = ANY(

	SELECT DISTINCT department_id 
	FROM departments 
	WHERE location_id IN (1400, 1700)

);
#not in
SELECT last_name FROM employees 
WHERE department_id NOT IN (

	SELECT DISTINCT department_id 
	FROM departments 
	WHERE location_id IN (1400, 1700)

);
#或者
SELECT last_name FROM employees 
WHERE department_id <> ALL(

	SELECT DISTINCT department_id 
	FROM departments 
	WHERE location_id IN (1400, 1700)

);
#案例2: 返回其他工种中比job_id为`IT_PROG`工种任一工资低的员工的员工号, 姓名, job_id以及salary
#①查询job_id为`IT_PROG`部门任一工资
SELECT DISTINCT salary FROM employees WHERE job_id = 'IT_PROG';
#②查询其他部门中比①中任一一个低的员工的员工号, 姓名, job_id以及salary
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < ANY(

	SELECT DISTINCT salary 
	FROM employees 
	WHERE job_id = 'IT_PROG'

) AND job_id <> 'IT_PROG';
#或者
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < (

	SELECT MAX(salary)
	FROM employees 
	WHERE job_id = 'IT_PROG'

) AND job_id <> 'IT_PROG';
#案例3: 返回其他工种中比job_id为`IT_PROG`工种所有工资低的员工的员工号, 姓名, job_id以及salary
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < ALL(

	SELECT DISTINCT salary 
	FROM employees 
	WHERE job_id = 'IT_PROG'

) AND job_id <> 'IT_PROG';
#或者
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < (

	SELECT MIN(salary) 
	FROM employees 
	WHERE job_id = 'IT_PROG'

) AND job_id <> 'IT_PROG';

#3. 行子查询(结果集是一行多列或多行多列)

#案例1: 查询员工编号最小并且工资最高的员工信息
SELECT * FROM employees
WHERE (employee_id, salary) = (

	SELECT MIN(employee_id), MAX(salary)
	FROM employees

);
#①查询最小的员工编号
SELECT MIN(employee_id)
FROM employees;
#②查询最高工资
SELECT MAX(salary)
FROM employees;
#③查询员工信息
SELECT * FROM employees
WHERE employee_id = (

	SELECT MIN(employee_id)
	FROM employees

) AND salary = (

	SELECT MAX(salary)
	FROM employees

);


#二. select后面
#仅仅支持标量子查询.

#案例1: 查询每个部门的员工个数
SELECT d.*, (

	SELECT COUNT(*) FROM employees e
	WHERE e.department_id = d.department_id

) 个数
FROM departments d;
#案例2: 查询员工号=102的部门号
SELECT (

	SELECT department_name FROM departments d
	INNER JOIN employees e
	ON d.`department_id` = e.`department_id`
	WHERE e.`employee_id` = 102

) 部门名;


#三. from后面
#支持表子查询.
#将子查询结果充当一张表, 要求必须起别名.

#案例1: 查询每个部门的平均工资的工资等级
#①查询每个部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;
#②连接①的结果集和job_grades表, 筛选条件平均工资between lowest_sal and highest_sal
SELECT ag_dep.*, g.`grade_level`
FROM (

	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id

) ag_dep
INNER JOIN job_grades g
ON ag_dep.ag BETWEEN lowest_sal AND highest_sal;


#四. exists后面(相关子查询)
#支持表子查询.
/*
语法:
    exists(完整的查询句子)
结果:
    1或0
*/

SELECT EXISTS(SELECT employee_id FROM employees WHERE salary = 30000);

#案例1: 查询有员工的部门名
#exists
SELECT department_name FROM departments d
WHERE EXISTS(

	SELECT *
	FROM employees e
	WHERE d.`department_id` = e.`department_id`

);
#in
SELECT department_name
FROM departments d
WHERE d.`department_id` IN(

	SELECT department_id
	FROM employees

);
#案例2: 查询没有女朋友的的男神信息
#in
SELECT bo.*
FROM boys bo
WHERE bo.id NOT IN(

	SELECT boyfriend_id
	FROM beauty

);
#exists
SELECT bo.*
FROM boys bo
WHERE NOT EXISTS(

	SELECT * 
	FROM beauty b
	WHERE bo.`id` = b.`boyfriend_id`

);


#案例讲解[子查询]

#1. 查询和Zlotkey相同部门的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE department_id = (

	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey'

);
#2. 查询工资比公司平均工资高的员工的员工号, 姓名和工资
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (

	SELECT AVG(salary)
	FROM employees

);
#3. 查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资
#①查询各部门的平均工资
SELECT AVG(salary), department_id FROM employees GROUP BY department_id;
#②连接①结果集和employees表, 进行筛选
SELECT employee_id, last_name, salary
FROM (

	SELECT AVG(salary) 平均工资, department_id 
	FROM employees 
	GROUP BY department_id

) d_avg
INNER JOIN employees e
ON d_avg.department_id = e.`department_id`
WHERE e.`salary` > d_avg.平均工资;
#4. 查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
#①查询姓名中包含字母u的员工所在的部门号
SELECT DISTINCT department_id FROM employees WHERE last_name LIKE '%u%';
#②查询部门号和①相同的员工的员工号和姓名
SELECT employee_id, last_name FROM employees
WHERE department_id IN (

	SELECT DISTINCT department_id 
	FROM employees 
	WHERE last_name LIKE '%u%'

);
#5. 查询在部门的location_id为1700的部门工作的员工的员工号
#①查询部门的location_id为1700的部门号
SELECT DISTINCT department_id FROM departments WHERE location_id = 1700;
#②查询部门号为①的员工的员工号
SELECT employee_id FROM employees 
WHERE department_id IN (

	SELECT DISTINCT department_id 
	FROM departments 
	WHERE location_id = 1700

);
#6. 查询管理者是King的员工姓名和工资
#①查询名字是King的员工的员工号
SELECT employee_id FROM employees WHERE last_name = 'K_ing';
#②查询管理者的员工号为①的员工的员工姓名和工资
SELECT last_name, salary FROM employees
WHERE manager_id IN (

	SELECT employee_id 
	FROM employees 
	WHERE last_name = 'K_ing'

);
#7. 查询工资最高的员工的姓名, 要求first_name和last_name显示为一列, 列名为姓.名
#①查询最高工资
SELECT MAX(salary) FROM employees;
#②查询工资=①的姓.名
SELECT CONCAT(first_name, last_name) '姓.名' FROM employees
WHERE salary = (

	SELECT MAX(salary) 
	FROM employees

);







