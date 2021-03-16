## 第一章 课程大纲

1. 为什么要学习数据库

2. 数据库的相关概念
   * DBMS, DB, SQL

3. 数据库存储数据的特点
4. 初始MySQL
   * mysql产品的介绍
   * mysql产品的安装
   * mysql服务的启动和停止
   * mysql服务的登录和退出
   * mysql的常见命令和语法规范
5. DQL(data query language)语言的学习(针对查询)
   * 基础查询
   * 条件查询
   * 排序查询
   * 常见函数
   * 分组函数
   * 分组查询
   * 子查询
   * 分页查询
   * union联合查询
6. DML(data manipulation language)语言的学习(增删改)
   * 插入语句
   * 修改语句
   * 删除语句
7. DDL(data define language)语言的学习
   * 库和表的管理
   * 常见数据类型介绍
   * 常见约束
8. TCL(transaction control language)语言的学习
   * 事务和事务处理
9. 试图的讲解
10. 变量
11. 存储过程和函数
12. 流程控制结构 



## 第二章 为什么要学习数据库

#### 1. 数据库的好处

1. 实现数据持久化;
2. 使用完整的管理系统统一管理, 易于查询.



## 第三章 数据库的相关概念

#### 1. DB

* 数据库(database): 存储数据的仓库. 它保存了一系列有组织的数据.

#### 2. DBMS

* 数据库管理系统(database management system): 又称为数据库软件(产品), 用于管理DB的数据. 数据库是通过DBMS创建和操作的容器.
* 常见的数据库管理系统: MySQL, Oracle, DB2, SqlServer等.

#### 3. SQL

* 结构化查询语言(structure query language): 专门用来与DBMS通信的语言.
* sql语言的优点: 
  1. 不是某个特定数据库供应商专有的语言, 几乎所有DBMS都支持SQL;
  2. 简单易学;
  3. 虽然简单, 但实际上是一种强有力的语言, 灵活使用其他语言元素, 可以进行非常复杂和高级的数据库操作.



## 第四章 数据库存储数据的特点

1. 将数据放到表中, 表再放到库中;
2. 一个数据库中可以有多个表, 每个表都有一个名字, 用来标识自己. 表名具有唯一性;
3. 表具有一些特性, 这些特性定义了数据在表中如何存储, 类似java中类的设计;
4. 表由列组成 ,也称为字段. 所有表都是由一个或多个列组成, 每一列类似java中的属性;
5. 表中的数据是按行存储的, 每一个行类似于java中的对象.



## 第五章 MySQL软件

#### 1. mysql数据库的介绍

* DBMS分为两类:

  1. 基于共享文件系统的DBMS(Access)
  2. 基于客户机-服务器的DBMS(mysql, oracle, sqlserver).

* 架构图: 

  ![](https://img-blog.csdnimg.cn/20190802164025521.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTM0NTI0,size_16,color_FFFFFF,t_70)

* 客户端:

  ![](https://img-blog.csdnimg.cn/20190802164135267.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTM0NTI0,size_16,color_FFFFFF,t_70)

* 服务器:

  ![](https://img-blog.csdnimg.cn/20190802164300986.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTM0NTI0,size_16,color_FFFFFF,t_70)

* 客户端和服务器通信:

  ![](https://img-blog.csdn.net/20161231152124671?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYm9vbGppYW95dQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

* DB(数据库):

  ![](https://img-blog.csdnimg.cn/20190802165654475.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTM0NTI0,size_16,color_FFFFFF,t_70)

* 表:

  ![](https://img-blog.csdnimg.cn/20190802170959697.png)

#### 2. mysql数据库的卸载

* 卸载完软件后还没卸载干净, 要进入C盘program files(x86)中, 将mysql文件删除, 还要进入programdata文件中, 这是一个隐藏文件, 将整个mysql文件删除.

* 如果按上面步骤依然没有清理干净, 可以按下图所示步骤清理:

  ![](D:\mysql-figure\1.png)

#### 3. mysql软件的安装

* 具体步骤: 自定义安装 -> 修改安装路径.
* 配置文件: 打开安装好的mysql文件下的bin目录, 点击配置程序, 选择精确配置, 选择开发机, 选择多功能数据库, 选择20, mysql数据库服务端的端口号是3306, 下面那个勾上对号, 选择手动选择字符集(utf8), 起名字, 下面那个对勾一定要选上, 设置密码, 打上对勾. 点执行.

#### 4. 配置文件介绍

1. my.ini: 里面有服务器(mysqld)的配置信息, 也有客户端的配置信息(mysql). 改完之后数据库服务器要重新启动一下. 

   ![](D:\mysql-figure\2.png)

#### 5. mysql服务的启动和停止

* 两种启动方式: 一种是通过系统服务启动; 另一种是通过命令行启动.
* `net stop mysql的服务名` : 停止mysql服务.
* `net start mysql的服务名` : 启动mysql服务.

#### 6. mysql服务的登录和退出(客户端)

* 登录之前要保证mysql服务是启动状态.
* (客户机)登录有两种方式: 一种是直接在mysql自带的客户端中输入密码登录. 退出命令: exit / ctrl + c. 这种方式不推荐, 因为只限于root用户. 另一种是在命令行中登录, 命令: `mysql -h(主机/服务器) localhost -P(端口号) 3306 -u(用户) root -p(密码)`. 注意: 主机名和端口号是可选的. 
* 登录之后就进入大仓库了.

#### 7. 配置环境变量

* 如果在命令行中输入命令时, 提示不是合法的内部命令, 说明环境变量没有配好. 那么需要重新配置一下. 要将mysql的bin目录的路径配到环境变量的最前面.

#### 8. mysql常见命令介绍

1. 查看当前所有的数据库: `show database;`
2. 打开指定的库: `use 库名;`
3. 查看当前库的所有表: `show tables;`
4. 查看其它库的所有表: `show tables from 库名;`
5. 创建表: `create table 表名(列名 类型名, 列名 类型名, ...);`
6. 查看表结构: `desc 表名;`
7. 查看服务器的版本:
   1. 方式一: 登录到mysql服务端 `select version();`
   2. 方式二: 没有登录到mysql服务端 `mysql --version` 或  `mysql -V`

#### 9. mysql语法规范介绍

1. 不区分大小写, 但建议关键字大写, 表名和列名小写;
2. 每条命令最好用分号结尾;
3. 每条命令根据需要, 可以进行缩进或换行;
4. 注释:
   1. 单行注释: #注释文字
   2. 单行注释: --` `注释文字
   3. 多行注释: `/*注释文字*/`

#### 10. 图形用户界面客户端

* sqlyog



## 第五章 DQL语言的学习

![](D:\mysql-figure\3.png)

#### 1. 基础查询

#### 2. 条件查询

#### 第一天学习内容的总结

**[一. 数据库的好处]()** :

1. 可以持久化数据到本地;
2. 结构化查询.

**[二. 数据库的常见概念]()** :

1. DB: 数据库, 存储数据的容器
2. DBMS: 数据库管理系统, 又称为数据库软件或数据库产品, 用于创建或管理DB
3. SQL: 结构化查询语言, 用于和数据库通信的语言, 不是某个数据库软件特有的, 而是几乎所有的主流数据库软件通用的语言.

**[三. 数据库存储数据的特点]()** :

1. 数据存放到表中, 然后表再存放到库中;
2. 一个库中可以有多张表, 每张表具有唯一的表名用来标识自己;
3. 表中有一个或多个列, 列又称为"字段", 相当于java中"属性";
4. 表中的每一行数据, 相当于java中"对象".

**[四. 常见的数据库管理系统]()** : 

mysql, oracle, db2, sqlserver.

**[五. mysql软件]()**

**[六. DQL语言]()** :

1. 注意: 使用select查询常量值时, 字符型和日期型的常量值必须用单引号引起来, 数值型不需要.
2. ifnull函数: 判断某字段或表达式是否为null, 如果为null, 返回指定的值, 否则返回原本的值.
3. isnull函数: 判断某字段或表达式是否为null, 如果是, 则返回1, 否则返回0.
4. 模糊查询中的like: 一般搭配通配符使用, 可以判断字符型数值或数值型.

#### 3. 排序查询

#### 4. 常见函数

1. **[单行函数]()** : 

   1. 字符函数;

   2. 数学函数;

   3. 日期函数;

      ![](D:\mysql-figure\4.png)

   4. 其他函数;

   5. 流程控制函数.

2. **[分组函数]()**

#### 5. 分组查询

#### 6. 连接查询

1. **[sql92]()**

2. **[sql99]()**

   ![](D:\mysql-figure\5.png)

   ![](D:\mysql-figure\6.png)