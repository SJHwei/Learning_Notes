 #常见的数据类型
/*

1. 数值型:
    (1) 整型
    (2) 小数:
        1> 定点数;
        2> 浮点数.

2. 字符型:
    (1) 较短的文本: char, varchar;
    (2) 较长的文本: text, blob(较长的二进制数据)

3. 日期型

*/


#一. 整型
/*

分类:
    Tinyint  一个字节
    Smallint  两个字节
    Mediumint  三个字节
    Int/integer  四个字节
    Bigint  八个字节
    
特点:
    ① 如果不设置无符号还是有符号, 默认是有符号, 如果想设置无符号, 需要添加unsigned关键字.
    ② 如果插入的数值超出了整型的范围, 会报out of range异常, 并且插入临界值.
    ③ 如果不设置长度, 会有默认的长度. 长度代表了显示的宽度, 如果不够会用0在左边填充, 但必须搭配zerofill使用.

*/

#1. 如何设置无符号和有符号

DROP TABLE IF EXISTS tab_int;

CREATE TABLE tab_int(

	t1 INT(7) ZEROFILL,
	t2 INT(7) ZEROFILL UNSIGNED

);

DESC tab_int;

INSERT INTO tab_int VALUES(-123456, -123456);

SELECT * FROM tab_int;

#二. 小数
/*

分类:
    1. 浮点数类型
        (1) float(M,D)  4个字节
        (2) double(M,D)  8个字节
    2. 定点数类型
        (1) DEC(M,D)/DECIMAL(M,D)  M+2个字节  最大范围与double相同, 给定decimal的有效取值范围由M和D决定

特点:
    ① M代表整数部位和小数部位的总长度, D代表小数部位的长度.
    ② M和D都可以省略:
        如果是decimal, 则M默认为10, D默认为0;
        如果是float和double, 则会根据插入的数值的精度来决定精度.
    ③ 定点型的精确度较高, 如果要求插入数值的精度较高如货币运算等则使用顶点型.

*/

#测试M和D

CREATE TABLE tab_float(

	f1 FLOAT(5,2),
	f2 DOUBLE(5,2),
	f3 DECIMAL(5,2)

);

INSERT INTO tab_float VALUES(123.45,123.45,123.45);
INSERT INTO tab_float VALUES(123.456,123.456,123.456);
INSERT INTO tab_float VALUES(123.4,123.4,123.4);
INSERT INTO tab_float VALUES(1523.4,1523.4,1523.4);

DESC tab_float;

SELECT * FROM tab_float;

#原则:
/*

所选择的类型越简单越好, 能保存数值的类型越小越好.

*/

#三. 字符型
/*

分类:
    1. 较短的文本:
        (1) char(M)  M表示最多字符数  char代表固定长度的字符
        (2) varchar(M)  M表示最多字符数  varchar代表可变长度的字符
    2. 较长的文本:
        (1) text
        (2) blob(较大的二进制)
    3. 其他:
        (1) binary和varbinary用于保存较短的二进制
        (2) enum用于保存枚举
        (3) set用于保存集合

特点:
    ① char和varchar的比较
		    写法        M的意思                        特点            空间的耗费        效率	
        char       char(M)    最大的字符数,可以省略,默认为1    固定长度的字符     比较耗费          高
        varchar   varchar(M)  最大的字符数,可以省略,默认为1    可变长度的字符     比较节省          低

*/

#测试较短文本中的enum类型(枚举类型)

CREATE TABLE tab_char(

	c1 ENUM('a','b','c')

);

INSERT INTO tab_char VALUES('a');
INSERT INTO tab_char VALUES('m');
INSERT INTO tab_char VALUES('A');

SELECT * FROM tab_char;

#测试较短文本中的set类型(集合类型),和enum类型的差别是: set类型一次可以选取多个成员,enum只能选一个.

CREATE TABLE tab_set(

	s1 SET('a','b','c','d')

);

INSERT INTO tab_set VALUES('a');
INSERT INTO tab_set VALUES('a,b');

#四. 日期类型
/*

分类:
                字节    最小值                最大值                   作用
    date         4   1000-01-01            9999-12-31              date只保存日期
    datetime     8   1000-01-01 00:00:00   9999-12-31 23:59:59     保存日期+时间
    timestamp    4   19700101080001        2038年的某个时刻         保存日期+时间
    time         3   -838:59:59            838:59:59               time只保存时间
    year         1   1901                  2155                    year只保存年
    
特点:
                   字节          范围           时区等影响
    datetime        4         1000-9999           不受
    timestamp       8         1970-2038            受
*/ 

#测试datetime和timestamp

CREATE TABLE tab_date(

	t1 DATETIME,
	t2 TIMESTAMP

);

INSERT INTO tab_date VALUES(NOW(),NOW());

SELECT * FROM tab_date;

SHOW VARIABLES LIKE 'time_zone';

SET time_zone='+9:00';




















