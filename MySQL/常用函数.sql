#进阶4: 常见函数
/*
重点: 一般用在select后, 也可以用在where,
概念: 类似于java中的方法, 将一组逻辑语句封装在方法体中, 对外暴露方法名
好处: 1.隐藏了实现细节; 2.提高代码的重用性
调用: select 函数名(实参列表) [from 表];
特点: 
    (1).叫什么(函数名)
    (2).干什么(函数功能)
分类:
    (1).单行函数:如concat,length,ifnull等;
        1>字符函数;
        2>数学函数;
        3>日期函数;
        4>其他函数;
        5>流程控制函数.
    (2).分组函数:功能是做统计使用, 又称为统计函数,聚合函数.
    
常见函数:
    字符函数: length,concat,substr,instr,trim,upper,lower,lpad,rpad,replace
    数学函数: round,ceil,floor,truncate,mod
    日期函数: now,curdate,curtime,year,month,monthname,day,hour,minute,second,str_to_date,date_format
    其他函数: version,database,user
    流程控制函数: if,case 
    
*/

#一. 字符函数

#1.length: 获取参数值的字节个数
SELECT LENGTH('john');
SELECT LENGTH('张三丰hahaha');

SHOW VARIABLES LIKE '%char%';

#2.concat: 拼接字符串
SELECT CONCAT(last_name, '_', first_name) 姓名 FROM employees;

#3.upper,lower: upper是变大写, lower是变小写
SELECT UPPER('john');
SELECT LOWER('joHn');
#示例: 将姓变大写, 名变小写, 然后拼接
SELECT CONCAT(UPPER(last_name), LOWER(first_name)) 姓名 FROM employees;

#4.substr,substring:
#注意: SQL中索引从1开始
#截取从指定索引处后面的所有字符
SELECT SUBSTR('李莫愁爱上了陆展元',7) out_put;
#截取从指定索引处指定字符长度的字符
SELECT SUBSTR('李莫愁爱上了陆展元',1,3) out_put;

#案例: 姓名中首字符大写, 其他字符小写然后用_拼接, 显示出来
SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)), '_', LOWER(SUBSTR(last_name,2))) out_put FROM employees;

#5.instr: 返回子串第一次出现的索引, 如果找不到返回0
SELECT INSTR('杨不悔爱上了殷六侠','殷六侠') AS out_put;

#6. trim: 去掉字符串前后的空格或指定的字符或指定的字符串
SELECT LENGTH(TRIM('        张翠山          ')) AS output;
SELECT TRIM('a' FROM 'aaaaaaaaaaa张aaaaaaa翠山aaaaaaaaaa') AS output;

#7. lpad: 用指定的字符实现左填充指定长度
SELECT LPAD('殷素素',10,'*') AS out_put;

#8. rpad: 用指定的字符实现右填充指定长度
SELECT RPAD('殷素素',12,'*') AS out_put;

#9. replace: 替换
SELECT REPLACE('周芷若周芷若张无忌爱上了周芷若','周芷若','赵敏') AS out_put;


#二. 数学函数

#1. round: 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(1.567, 2); #2表示小数点后

#2. ceil: 向上取整, 返回>=该参数的最小整数
SELECT CEIL(1.01);

#3. floor: 向下取整, 返回<=该参数的最大整数
SELECT FLOOR(-9.99);

#4. truncate: 截断, 第二个参数表示小数点后保留几位
SELECT TRUNCATE(1.6999,1);

#5. mod: 取余, a-a/b*b, 结果的正负取决于被除数的正负
SELECT MOD(-10, -3); 
SELECT 10%3;


#三. 日期函数

#1. now: 返回当前系统日期+时间
SELECT NOW();

#2. curdate: 返回当前系统日期, 不包含时间
SELECT CURDATE();

#3. curtime: 返回当前时间, 不包含日期
SELECT CURTIME();

#4. 可以获取指定的部分, 年, 月, 日, 小时, 分钟, 秒
SELECT YEAR(NOW()) 年;
SELECT YEAR('1998-1-1') 年;
SELECT YEAR(hiredate) 年 FROM employees;

SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月; #英文月名

#5. str_to_date: 将日期格式的字符转换成指定格式的日期, 注意: 是指定的格式
SELECT STR_TO_DATE('1998-3-2', '%Y-%c-%d') AS out_put;

#查询入职日期为1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#6. date_format: 将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%y年%m月%d日') AS out_put;

#查询有奖金的员工名和入职日期(xx月/xx日 xx年)
SELECT last_name, DATE_FORMAT(hiredate,'%m月/%d日 %y年') FROM employees WHERE commission_pct IS NOT NULL;


#四. 其他函数

SELECT VERSION();
SELECT DATABASE();
SELECT USER();


#五. 流程控制函数

#1. if函数: if else 的效果
SELECT IF(10<5, '大','小');
SELECT last_name, commission_pct, IF(commission_pct IS NULL,'没奖金, 呵呵', '有奖金, 嘻嘻') 备注 FROM employees;

#2. case函数的使用一: switch case 的效果
#这个用法适用于等值的情况.
/*
java中的语法:
    switch(变量或表达式){
	case 常量1: 语句1; break;
	...
	default: 语句n; break;
    }

mysql中的语法:
    case 要判断的字段或表达式
    when 常量1 then 要显示的值1或 语句1;
    when 常量1 then 要显示的值2或 语句2;
    ...
    else 要显示的值n或 语句n;
    end

case可以放在select后当表达式使用, 此时then后是值, 不是语句, 这时后面不加分号;
case可以单独使用, 此时then后的是语句, 不是值, 这时后面加分号.
*/

#案例: 查询员工的工资, 要求:
/*
部门号=30, 显示的工资为1.1倍
部门号=40, 显示的工资为1.2倍
部门号=50, 显示的工资为1.3倍
其他部门, 显示的工资为原工资
*/
SELECT salary 原始工资, department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新工资
FROM employees;

#3. case函数的使用二: 类似于多重if
#这个用法适用于范围的情况.
/*
java中的语法:
if(条件1){
    语句1;
}else if(条件2){
    语句2;
}
...
else{
    语句n;
}

mysql中的语法:
case
when 条件1 then 要显示的值1或 语句1;
when 条件2 then 要显示的值2或 语句2;
...
else 要显示的值n或 语句n;
end

*/

#案例: 查询员工工资的情况
/*
如果工资>20000, 显示A级别
如果工资>15000, 显示B级别
如果工资>10000, 实现C级别
否则, 显示D级别
*/
SELECT salary,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;


#单行函数的案例讲解

#1.显示系统时间(注:日期+时间)
NOW();
#2.查询员工号,姓名,工资,以及工资提高百分之20后的结果(NEW salary)
#3.将员工的姓名按首字母排序,并写出姓名的长度(LENGTH)
#4.做一个查询,产生下面的结果
#<last_name> earns <salary> monthly but wants <salary*3>
#Dream Salary
#King earns 24000 monthly but wants 72000
#5.使用case-when,按照下面的条件:
#job        grade
#AD_PRES    A
#ST_MAN     B
#IT_PROG    C























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
    
    4>group by子句支持单个字段分组, 多个字段分组(多个字段之间用逗号隔开没有顺序要求), 表达式或函数(用的较少)
    5>也可以添加排序(排序放在整个分组查询的最后)

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
    
#按表达式或函数分组

#案例: 按员工姓名的长度分组, 查询每一组的员工个数, 筛选员工个数>5的有哪些
SELECT COUNT(*), LENGTH(last_name) len_name FROM employees GROUP BY LENGTH(last_name) HAVING COUNT(*) > 5;
SELECT COUNT(*) c, LENGTH(last_name) len_name FROM employees GROUP BY len_name HAVING c > 5;

#按多个字段分组

#案例: 查询每个部分每个工种的员工的平均工资
SELECT department_id, job_id, AVG(salary) FROM employees GROUP BY department_id, job_id;

#添加排序

#案例: 查询每个部门每个工种的员工的平均工资, 并且按平均工资的高低显示
SELECT AVG(salary) a, department_id, job_id FROM employees WHERE department_id IS NOT NULL
GROUP BY job_id, department_id 
HAVING a > 10000
ORDER BY a DESC;


#案例讲解[分组查询]

#1.查询各job_id的员工工资的最大值, 最小值, 平均值, 总和, 并按job_id升序
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary) FROM employees GROUP BY job_id ORDER BY job_id;
#2.查询员工最高工资和最低工资的差距(DIFFRENCE)
SELECT MAX(salary) - MIN(salary) AS DIFFRENCE FROM employees;
#3.查询各个管理者手下员工的最低工资, 其中最低工资不能低于6000, 没有管理者的员工不计算在内
SELECT MIN(salary) FROM employees WHERE manager_id IS NOT NULL GROUP BY manager_id HAVING MIN(salary) >= 6000;
#4.查询所有部门编号, 员工数量和工资平均值, 并按平均工资降序
SELECT department_id, COUNT(employee_id), AVG(salary) FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC;
#5.选择具有各个job_id的员工人数
SELECT COUNT(*) FROM employees GROUP BY job_id;












