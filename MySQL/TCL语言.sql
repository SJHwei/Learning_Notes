#TCL(Transaction Control Language) 事务控制语言
/*

事务: 
    (概括版)一个或一组sql语句组成一个执行单元, 这个执行单元要么全部执行, 要么全部不执行.
    (具体版)事务由单独单元的一个或多个sql语句组成, 在这个单元中, 每个mysql语句是相互依赖的. 
           而这个单独单元作为一个不可分割的整体, 如果单元中某条sql语句一旦执行失败或产生错误, 整个单元将会回滚.
           所有受到影响的数据将返回到事物开始以前的状态; 如果单元中的所有sql语句均执行成功, 则事物被顺利执行.

事务的ACID属性(事务的特性):
    1. 原子性(Atomicity):
        原子性是指事务是一个不可分割的工作单位, 事务中的操作要么都发生, 要么都不发生.
    2. 一致性(Consistency):
        事务必须使数据库从一个一致性状态变换到另外一个一致性状态.
    3. 隔离性(Isolation):
        事务的隔离性是指一个事务的执行不能被其他事务干扰, 即一个事务内部的操作及使用的数据对并发的其他事务是隔离的, 并发执行的各个事务之间不能互相干扰.
    4. 持久性(Durability):
        持久性是指一个事务一旦被提交, 它对数据库中数据的改变就是永久性的, 接下来的其他操作和数据库故障不应该对其有任何影响.

事务的分类:
    1. 隐式事务: 事务没有明显的开启和结束的标记, 比如insert, update, delete语句, 采用的是自动提交(autocommit)的方式.
    2. 显示事务: 事务具有明显的开启和结束的标记, 前提是必须先设置自动提交功能为禁用. set autocommit=0; 

事务的使用步骤:
	步骤1: 开启事务
	    set autocommit=0;
	    start transaction; #可选的
	步骤2: 编写事务中的sql语句(select insert update delete)
	    语句1;
	    语句2;
	    ...
	步骤3: 结束事务
	    commit; #提交事务
	    rollback; #回滚事务
	    savepoint 节点名; 设置保存点

事务并发问题的介绍:
    1. 对于同时运行的多个事务, 当这些事务访问数据库中相同的数据时, 如果没有采取必要的隔离机制, 就会导致各种并发问题:
        (1)脏读: 对于两个事务T1和T2, T1读取了已经被T2更新但还没有被提交的字段, 之后, 若T2回滚, T1读取的内容就是临时且无效的.
        (2)不可重复读: 对于两个事务T1和T2, T1读取了一个字段, 然后T2更新了该字段, 之后, T1再次读取同一个字段, 值就不同了.
        (3)幻读: 对于两个事务T1和T2, T1从一个表中读取了一个字段, 然后T2在该表中插入了一些新的行. 之后, 如果T1再次读取同一个表, 就会多出几行.
    2. 数据库事务的隔离性: 数据库系统必须具有隔离并发运行各个事务的能力, 使它们不会相互影响, 避免各种并发问题.
    3. 数据库的隔离级别: 一个事务与其他事务隔离的程度称为隔离界别. 数据库规定了多种事务隔离级别, 不同隔离级别对应不同的干扰程度, 隔离级别越高, 数据一致性就越好, 但并发性越弱.
        (1)数据库提供的4种事务隔离级别:
            ①read uncommitted(读未提交数据): 允许事务读取未被其他事物提交的变更. 脏读, 不可重复读和幻读的问题都会出现.
            ②read commited(读已提交数据): 只允许事务读取已经被其他事务提交的变更. 可以避免脏读. 但不可重复读和幻读问题仍然存在.
            ③repeatable read(可重复读): 确保事务可以多次从一个字段中读取相同的值. 在这个事务持续期间, 禁止其他事物对这个字段进行更新. 可以避免脏读和不可重复读, 但幻读的问题仍然存在.
            ④serializable(串行化): 确保事务可以从一个表中读取相同的行. 在这个事务持续期间, 禁止其他事务对该表执行插入, 更新和删除操作. 所有并发问题都可以避免, 但性能十分低下.   
        (2)Oracle支持2种隔离级别: read commited和serializable. 默认为read commited.
        (3)mysql支持4种隔离级别. 默认为repeatable read. 
    4. 演示事务的隔离级别(在命令行窗口中演示):
        (1)每启动一个mysql程序, 就会获得一个单独的数据库连接. 每个数据库连接都有一个全局变量@@tx_isolation, 表示当前的事务隔离级别.
        (2)连接mysql服务器: mysql -u root -p 1109
        (3)查看mysql的当前隔离级别: select @@tx_isolation;
        (4)设置当前mysql连接的隔离级别: set session transaction isolation level read uncommitted;
        (5)设置数据库系统的全局的隔离级别: set global transaction isolation level read committed;

案例: 转账

    张三丰  1000;
    郭襄    1000;
    
    update 表 set 张三丰的余额=500 where name='张三丰';
    意外
    Update 表 set 郭襄的余额=1500 where name='郭襄';
    
MySQL中的存储引擎:
    1. 概念: 在mysql中的数据用各种不同的技术存储在文件(或内存)中.
    2. 通过show engines; 来查看mysql支持的存储引擎.
    3. 在mysql中用的最多的存储引擎有: innodb, myisam, memory等. 其中innodb支持事务, 而myisam, memory等不支持事务.

*/

SHOW VARIABLES LIKE 'autocommit';

DROP TABLE IF EXISTS account;

CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20),
	balance DOUBLE

);

INSERT INTO account(username, balance) VALUES('张无忌', 1000), ('赵敏', 1000);

SELECT * FROM account;


#1. 演示事务的使用步骤:

#步骤1: 开启事务
SET autocommit=0;
START TRANSACTION;
#步骤2: 编写一组事务的语句
UPDATE account SET balance=1000 WHERE username='张无忌';
UPDATE account SET balance=1000 WHERE username='赵敏';
#结束事务
ROLLBACK;
COMMIT;

SELECT * FROM account;

#2. 演示事务对于delete和truncate的处理的区别

#演示delete，支持回滚
SET autocommit=0;
START TRANSACTION;
DELETE FROM account;
ROLLBACK;

#演示truncate，不支持回滚
SET autocommit=0;
START TRANSACTION;
DELETE FROM account;
ROLLBACK;

#3. 演示savepoint的使用

SET autocommit=0;
START TRANSACTION;
DELETE FROM account WHERE id=25;
SAVEPOINT a; #设置保存点
DELETE FROM account WHERE id=28;
ROLLBACK TO a; #回滚到保存点

SELECT * FROM account;





















