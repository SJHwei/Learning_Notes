#进阶2: 条件查询
/*
语法: select 查询列表 from 表名 where 筛选条件(看哪一行满足要求);

执行顺序: from 表名;  where 筛选条件;  select 查询列表.

分类: 
         一. 按条件表达式筛选
               条件运算符:  >  <  =  <>(!=)  >=  <=
         二. 按逻辑表达式筛选  
                逻辑运算符:  &&(and)  ||(or)  !(not)
                作用: 用于连接条件表达式
         三. 模糊查询
                like
                between and
                in
                is null
*/
# 一. 按条件表达式筛选

# 案例1: 查询工资>12000的员工信息
SELECT
                    *
 FROM
                employees
 WHERE
                    salary>12000;
                    
#案例2: 查询部门编号不等于90号的员工名和部分编号
SELECT
                 last_name,
                 department_id
FROM
                      employees
 WHERE
                      department_id<>90;
                      
 # 二. 按逻辑表达式筛选
 
 #案例1: 查询工资在10000到20000之间的员工名, 工资以及奖金
 SELECT
                      last_name,
                      salary,
                      commission_pct
FROM
			employees
WHERE
			salary>=10000 AND salary <=20000;

#案例2: 查询部门编号不是在90到110之间, 或者工资高于15000的员工信息
SELECT
			*
FROM
			employees
WHERE
			NOT(department_id >= 90 AND department_id <= 110) OR salary > 15000;