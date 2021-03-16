#变量
/*
系统变量:
    (1)全局变量
    (2)会话变量

自定义变量:
    (1)用户变量
    (2)局部变量

*/


#一、系统变量
/*
说明：变量由系统提供，不是用户定义，属于服务器层面。

使用语法：
    1、查看所有的系统变量：show global|【session】 variables;
    2、查看满足条件的部门系统变量：show global|【session】 variables like '%char%';
    3、查看指定的某个系统变量的值：select @@global|【session】.系统变量名;
    4、为某个系统变量赋值
        （1）方式一：set global|【session】 系统变量名 = 值;
        （2）方式二：set @@global|【session】.系统变量名 = 值; 

注意：如果是全局级别，则需要加global，如果是会话级别，则需要加session，如果不写，则默认session。

全局变量作用域：服务器每次启动将为所有的全局变量赋初始值，修改全局变量后针对于所有的会话（连接）有效，但不能跨重启。

会话变量作用域：仅仅针对于当前会话（连接）有效。

*/


#二、自定义变量
/*
说明：变量是用户自定义的，不是系统的。

使用步骤：声明；赋值；使用（查看，比较，运算等）

用户变量作用域：针对于当前会话（连接）有效，同于会话变量的作用域。应用在任何地方，也就是beign end里面或beign end的外面。

局部变量作用域：仅仅在定义它的beign end中有效。应用在beign end中的第一句话。

*/

#1、用户变量
/*
赋值的操作符：=或:=

①声明并初始化
set @用户变量名=值; 或
set @用户变量名:=值; 或
select @用户变量名:=值;

②赋值（更新用户变量的值）
    方式一：通过set或select
           set @用户变量名=值; 或
           set @用户变量名:=值; 或
           select @用户变量名:=值;
    方式二：通过select into 【注意：查询出来的值必须是一个值】
           select 字段 into @变量名 from 表;

③使用（查看用户变量的值）
select @用户变量名;
*/


#案例：
#声明并初始化
SET @name='john';
SET @name=100;
SET @count=1;
#赋值
SELECT COUNT(*) INTO @count
FROM employees;
#查看
SELECT @count;

#2、局部变量
/*
①声明：
    declare 变量名 类型;
    declare 变量名 类型 default 值;

②赋值：
    方式一：通过set或select
           set 局部变量名=值; 或
           set 局部变量名:=值; 或
           select @局部变量名:=值;
    方式二：通过select into 【注意：查询出来的值必须是一个值】
           select 字段 into 变量名 from 表;

@使用：
    select 局部变量名;



*/

#对比用户变量和局部变量：
/*
              作用域           定义和使用的位置                       语法
用户变量      当前会话          会话中的任何地方                    必须加@符号，不用限定类型
局部变量      beign end中      只能在beign end中，且为第一句话      一般不用加@符号，除非使用select，需要限定类型

*/

#案例：声明两个变量并赋初始值，求和，并打印

#1、用户变量
SET @m=1;
SET @n=2;
SET @sum=@m+@n;
SELECT @sum;

#2、局部变量【错误】
DECLARE m INT DEFAULT 1;
DECLARE n INT DEFAULT 2;
DECLARE SUM INT;
SET SUM=m+n;
SELECT SUM;