#二. 分组函数
/*
功能: 用作统计使用, 又称为聚合函数或统计函数或组函数
分类:
    sum求和, avg平均值, max最大值, min最小值, count计算个数
注意: 对于单行函数, 给它一组值, 单行函数会返回给一组值;
      对于分组函数, 给它一组值, 分组函数会返回一个值.
特点:
(1) sum,avg一般用于处理数值型;
    max,min,count可以处理任何类型.
(2) 以上分组函数都忽略null值.
*/
#1.简单的使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;
SELECT SUM(salary) 和,ROUND(AVG(salary), 2) 平均,MAX(salary) 最高,MIN(salary) 最低,COUNT(salary) 个数 FROM employees;

#2.参数支持哪些类型

#3.是否忽略null