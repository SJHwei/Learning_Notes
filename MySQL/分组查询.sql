#进阶5: 分组查询
/*
group by子句:
(1)作用: 可以使用group by子句将表中的数据分成若干组
(2)语法:
    select group_function(column)[分组函数],column(要求是出现在group by后面的字段)
    from table
    [where condition]
    group by group_by_expression(分组的列表)
    [order by column]
(3)明确: where一定放在from后面
(4)注意: 查询列表(select后)比较特殊, 要求是分组函数和group by后出现的字段
(5)注意: 当一个问题复杂而且涉及分组时, 可以分步进行.
         一般分为三步:
             第一步: 先得到select, from, group by
             第二步: 加上where
             第三步: 加上having
(6)特点: 
    1>分组查询中的筛选条件分为两类:
                     数据源            位置                    关键字
    分组前筛选        原始表            group by子句的前面       where
    分组后筛选        分组后的结果集     group by子句的后面       having
    2>分组函数做条件肯定放在having子句中
    3>能用分组前筛选的, 就优先考虑使用分组前筛选

*/

#简单的分组查询

#案例1: 查询每个工种的最高工资
SELECT MAX(salary), job_id FROM employees GROUP BY job_id;
#案例2: 查询每个位置上的部门个数
SELECT COUNT(*), location_id FROM departments GROUP BY location_id;

#添加分组前的筛选条件

#案例1: 查询邮箱中包含a字符的, 每个部门的平均工资
SELECT AVG(salary), department_id FROM employees WHERE email LIKE '%a%' 
GROUP BY department_id;
#案例2: 查询有奖金的每个领导手下的员工的最高工资
SELECT MAX(salary), manager_id FROM employees WHERE commission_pct IS NOT NULL 
GROUP BY manager_id;

#添加分组后的筛选条件(使用having, 可以在结果集上添加筛选条件)

#案例1: 查询哪个部门的员工个数>2
    #(1)查询每个部门的员工个数
    SELECT COUNT(*), department_id FROM employees GROUP BY department_id;
    #(2)根据(1)的结果进行筛选, 查询哪个部门的员工个数>2
    SELECT COUNT(*), department_id FROM employees GROUP BY department_id
    HAVING COUNT(*) > 2;
#案例2: 查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT job_id, MAX(salary) FROM employees WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary) > 12000;
#案例3: 查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个, 以及其最低工资
    #(1)查询领导编号>102的每个领导手下的最低工资
    SELECT manager_id, MIN(salary) FROM employees WHERE manager_id > 102 GROUP BY manager_id;
    #(2)根据(1)的结果进行筛选, 查询手下最低工资>5000的领导编号和最低工资
    SELECT manager_id, MIN(salary) FROM employees WHERE manager_id > 102 GROUP BY manager_id
    HAVING MIN(salary) > 5000;
    

