## 第一章 mybatis的学习前言

#### 1. 学习大纲

1. 第一阶段:
   * mybatis入门
   * mybatis的概述
   * mybatis的环境搭建
   * mybatis入门案例
   * 自定义mybatis框架(主要的目的是为了让大家了解mybatis中执行细节)
2. 第二阶段:
   * mybatis基本使用
   * mybatis的单表crud操作
   * mybatis的参数和返回值
   * mybatis的dao编写
   * mybatis配置的细节, 几个标签的使用
3. 第三阶段:
   * mybatis的深入和多表
   * mybatis的连接池
   * mybatis的事务控制及设计的方法
   * mybatis的多表查询, 一对多, 多对一, 多对多
4. 第四阶段:
   * mybatis的缓存和注解开发
   * mybatis中的加载时机(查询的时机)
   * mybatis中的一级缓存和二级缓存
   * mybatis的注解开发, 单表crud, 多表查询

#### 2. 三层框架和ssm框架

![](D:\ssm框架-figure\1.png)

* 什么是框架?
  * 它是我们软件开发中的一套解决方案, 不同的框架解决的是不同的问题. 
  * 使用框架的好处: 框架封装了很多的细节, 使开发者可以使用极简的方式实现功能. 大大提高开发效率.
* 三层架构
  * 表现层: 是用于展示数据的
  * 业务层: 是处理业务需求的
  * 持久层: 是和数据库交互的

#### 3. JDBC介绍

1. **[JDBC概述]()** : 

   ![](https://img-blog.csdnimg.cn/20191024143621239.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDI5NjkyOQ==,size_16,color_FFFFFF,t_70)

   * JDBC(java database connectivity, java数据库连接)是一种用于**执行SQL语句**的`java API`, **可以为多种关系数据库提供统一访问**. 它由一组用java语言编写的类和接口组成, JDBC提供一种基准, 据此可以构建更高级的工具和接口, 使数据库开发人员能编写数据库应用程序.
   * 通俗来说就是因为java程序员需要连接多种数据库, 为了避免每一种数据库都学习一套新的api, sun公司提出了一个JDBC的接口, 各个数据库的厂商根据此接口写实现类(驱动), 这样java程序员只需要掌握JDBC接口的调用, 即可访问任何数据库.

2. **[执行JDBC的流程]()** : 

   1. 注册驱动(加载数据库驱动)
   2. 获取连接对象(connection)
   3. 创建SQL执行对象(Statement)
   4. 执行SQL语句
   5. 关闭资源

3. **[JDBC核心类(接口)介绍]()** : 

   ​		JDBC的核心类有: `DriverManager, Connection, Statement, ResultSet`.

   1. `DriverManager类` : 驱动管理器, 是管理一组JDBC驱动程序的基本服务, 主要用于**注册驱动和获取连接**.
   2. `Connection接口` : 如果可以获取到Connection对象, 那么说明已经与数据库连接上了, Connection对象表示连接, 与数据库的通讯录都是通过这个对象展开的, Connection最重要的一个方法就是用来获取Statement对象和PreparedStatement对象.
   3. `Statement接口` : statement对象是SQL语句的执行者, 是用来向数据库发送SQL语句的.
   4. `ResultSet接口` : resultset用于代表sql语句的执行结果. resultset封装执行结果时, 才哟你的类似于表格的方式, resultset对象维护了一个指针, 初始的时候, 指针指向的是结果集的第一行, 可以通过提供的api对指针进行操作, 查看结果集.

4. **[整体流程(使用mysql数据库)]()** : 

   1. 首先创建maven项目, 然后在pom.xml添加依赖;
   2. 添加一个配置文件jdbc.properties放在src/resources, 配置数据库的连接信息;
   3. 添加一个class类, 添加一个静态块, 然后读取配置文件. 通常情况下, 这个过程是每次都要执行的, 所以一般都封装成一个DBUtils类, 然后每次直接调用就行了;
   4. 注册驱动, 获取连接, 将这两部封装在DBUtils中的一个getConn()方法中, 便于后续调用;
   5. 关闭资源, 也封装为DBUtils的一个close()方法.

5. **[代码实现]()** : 

   ![](D:\ssm框架-figure\2.png)

   ![](D:\ssm框架-figure\3.png)

   ![](D:\ssm框架-figure\4.png)

#### 4. jdbc操作数据库的问题分析

* JDBC技术: Connection, PreparedStatement, ResultSet. 
* Spring的JdbcTemplate: Spring中对jdbc的简单封装
* Apache的DBUtils: 它和Spring的JdbcTemplate很像, 也是对Jdbc的简单封装.
* 以上这些都不是框架, JDBC是规范, Spring的JdbcTemplate和Apache的DBUtils都只是工具类.



## 第二章 mybatis基本说明

#### 1. mybatis概述

* mybatis是一个持久层框架, 用java编写的. 
* 它封装了jdbc操作的很多细节, 使开发者只需要关注sql语句本身, 而无需关注注册驱动, 创建连接等繁杂过程.
* 它使用了ORM思想实现了结果集的封装.
* ORM(object relation mapping): 对象关系映射, 简单的说就是把数据库表和实体类及实体类的属性对应起来. 让我们可以操作实体类就实现操作数据库表.
* 要做到实体类中的属性和数据库表的字段名称保持一致. 

#### 2. mybatis环境搭建

1. **[步骤]()** : 

   * 第一步: 创建maven工程并导入坐标;
   * 第二步: 创建实体类和dao的接口;
   * 第三步: 创建mybatis的主配置文件SqlMapConfig.xml;
   * 第四步: 创建映射配置文件IUserDao.xml.

2. **[环境搭建的注意事项]()** : 

   * 第一个: 创建IUserDao.xml和IUserDao.java时名称是为了和之前的知识保持一致. 在mybatis中它把持久层的操作接口名称和映射文件也叫做Mapper, 所以IUserDao和IUserMapper是一样的.
   * 第二个: 在IDEA中创建目录的时候, 它和包是不一样的, 包在创建时, com.itheima.dao它是三级结构; 目录在创建时, com.itheima.dao是一级目录.
   * 第三个: mybatis的映射配置文件位置必须和dao接口的包结构相同.
   * 映射配置文件和mapper标签namespace属性的取值必须是dao接口的全限定类名.
   * 映射配置文件的操作配置(select), id属性的取值必须是dao接口的方法名.

   注意: 当我们遵从了第三, 四, 五点之后, 我们在开发中就无需再写dao的实现类, mybatis就都做了.

3. **[mybatis入门案例]()** : 

   * 第一步: 读取配置文件
   * 第二步: 创建SqlSessionFactory工厂
   * 第三步: 创建SqlSession
   * 第四步: 创建Dao接口的代理对象
   * 第五步: 执行dao中的方法
   * 第六步: 释放资源
   
   注意事项: 不要忘记在映射配置中告知mybatis要封装到哪个实体类中, 配置的方式是指定实体类的全限定类名.
   
4. **[mybatis基于注解的入门案例]()** : 

   * 把IUserDao.xml移除, 在dao接口的方法上使用@select注解, 并且指定SQL语句, 同时需要在SqlMapConfig.xml中的mapper配置时, 使用class属性指定dao接口的全限定类名.
   * 明确: 在实际开发中, 都是越简便越好, 所以都是采用不写dao实现类的方式. 不管使用XML还是注解配置. 但是mybatis它是支持写dao实现类的.

5. **[mybatis入门案例中的设计模式分析]()** : 

   ![](D:\ssm框架-figure\11.png)

6. **[自定义mybatis的分析 - 执行查询所有(SelectList方法)分析]()** : 

   * mybatis在使用代理dao的方式实现增删改查时做了什么事呢? (只有两件事)
     1. 第一: 创建代理对象;
     2. 第二: 在代理对象中调用selectList.
   * 执行`selectList方法`分析 : 

   ![](D:\ssm框架-figure\13.png)

   ![](D:\ssm框架-figure\14.png)

   ![](D:\ssm框架-figure\15.png)

7. **[自定义mybatis的分析 - 创建代理对象的分析]()** : 

   ![](D:\ssm框架-figure\16.png)

8. **[自定义mybatis的编码 - 根据测试类中缺少的创建接口和类]()** : 

   * 自定义mybatis能通过入门案例看到的类: 
     1. class Resources
     2. class SqlSessionFactoryBuilder
     3. interface SqlSessionFactory
     4. interface SqlSession
   
9. **[自定义mybatis的编码 - 解析XML的工具类介绍]()**

10. **[自定义mybatis的编码 - 创建两个默认实现类并分析类之间的关系]()**

11. **[自定义mybatis的编码 - 实现基于XML的查询所有操作]()**

12. **[自定义mybatis的编码 - 实现基于注解配置的查询所有]()**

#### 3. 今日内容课程介绍

1. **[回顾mybatis的自定义再分析和环境搭建+完善基于注解的mybatis]()**
2. **[mybatis的curd(基于代理dao的方式)]()**
3. **[mybatis中的参数深入及结果集的深入]()**
4. **[mybatis中基于传统dao的方式(编写dao的实现类)]()**
5. **[mybatis中的配置(主配置文件: SqlMapConfig.xml)]()** :
   * properties标签
   * typeAliases标签
   * mappers标签



## 第三章 mybatis的CRUD操作

#### 1. 保存操作(添加)

#### 2. 修改和删除操作

#### 3. 查询操作

* **[查询一个操作]()** 

* **[模糊查询操作]()** :

  ![](D:\ssm框架-figure\17.png)

  ![](D:\ssm框架-figure\18.png)

  ![](D:\ssm框架-figure\19.png)

#### 4. 查询返回一行一列和占位符分析

#### 5. 保存操作的细节-获取保存数据的id

![](D:\ssm框架-figure\20.png)

* **select last_insert_id()** : 可以得到新增用户的id值.


## 第四章 mybatis的参数和返回值

#### 1. Mybatis中参数的深入-使用实体类的包装对象作为查询条件

* **[Mybatis的参数]()**
  1. **parameterType(输入类型)**
  2. **传递简单类型**
     * 类型名可以随便写, 大小写都可以, 只要能表明类型即可.
  3. **传递pojo对象(实体类)**
     * mybais使用ognl表达式解析对象字段的值, #{}或者${}括号中的值为pojo属性名称.
     * **ognl表达式**(#{}中的内容) : 
       1. Object Graphic Navigation Language (对象图导航语言)
       2. 它是通过对象的取值方法来获取数据, 在写方法上把get给省略了.
       3. 实例: 比如获取用户的名称.
          * 类中的写法: user.getUsername()
          * ognl表达式的写法: user.username()
       4. mybatis中为什么能直接写username, 而不用user呢?
          * 因为在parameterType中已经提供了属性所属的类, 所以此时不需要写对象名.
  4. **传递pojo包装对象**
     * 开发中通过pojo传递查询条件, 查询条件是综合的查询条件, 不仅包括用户查询条件还包括其它的查询条件(比如将用户购买商品信息也作为查询条件), 这时可以使用包装对象传递输入参数. pojo类中包含pojo.
     * 需求: 根据用户名查询用户信息, 查询条件放到QueryVo的user属性中. 

#### 2. Mybatis中的返回值深入-调整实体类属性解决增和改方法的报错

* **resultType(输出类型)**：
    1. **输出简单类型**：int...
    2. **输出pojo对象[^概念]**
    3. **输出pojo列表**

* **注意**：当使用查询封装时，要求实体类必须和数据库的列名保持一致。如果不一致呢？答：对于增删改没有影响，但是对于查询有影响，在windows下的MySQL，它不区分大小写，所以数据库中和实体类的字段相同的列名可以封装进去，不相同的则封装不进去，为null。但是在linux下的MySQL区分大小写。解决思路一共有两种，下一节说明。

#### 3. Mybatis中的返回值深入-解决实体类属性和数据库列名不对应的两种方法

1. 方法一：在MySQL语句中对列名起别名。
2. 方法二：采用配置的方法。配置查询结果的列名和实体类的属性名的对应关系。

[^概念]: pojo(plain ordinary java object), 纯洁老式的java对象/简单java对象。pojo内在含义是指呢些没有从任何类继承，也没有实现任何接口，更没有被其他框架侵入的java对象。即有无参数构造方法，每个字段都有getter和setter的java类。

## 第五章 Mybatis中编写dao实现类

#### 1. 查询列表

#### 2. 保存操作

#### 3. 修改删除等其他操作

## 第六章 Mybatis中使用Dao实现类的执行过程分析

#### 1. 查询方法

#### 2. 增删改方法

## 第七章 Mybatis中标签的说明

#### 1. properties标签的使用及细节

#### 2. typeAliases标签

#### 3. package标签

## 第八章 Mybatis中的连接池以及事务控制(原理部分了解, 应用部分会用)

#### 1. mybatis中连接池使用及分析

1. **连接池:**
    我们在实际开发中都会使用连接池. 因为它可以减少我们获取连接所消耗的时间.
    1. 连接池就是用于存储连接的一个容器;
    2. 容器其实就是一个集合对象, 该集合必须是线程安全的, 不能两个线程拿到同一个连接;
    3. 该集合还必须实现队列的特性: 先进先出.
    ![](D:\ssm框架-figure\22.png)
2. **mybatis中的连接池:**
    mybatis连接池提供了3中方式的配置.
    1. 配置的位置: 主配置文件SqlMapConfig.xml中的dataSource标签, type属性就是表示采用何种连接池方式.
    2. type属性的取值: 
        * ***POOLED***: 采用传统的javax.sql.DataSource规范中的连接池, mybatis中有针对规范的实现.
        * ***UNPOOLED***: 采用传统的获取连接的方式, 虽然也实现了javax.sql.DataSource接口, 但是没有使用池的思想.
        * ***JNDI***: 采用服务器提供的JNDI技术实现, 来获取DataSource对象, 不同的服务器所能拿到DataSource是不一样的. 如果不是web或者maven的war工程, 是不能使用的. 我们课程中使用的是tomcat服务器, 采用连接池就是dbcp连接池.
3. **mybatis中的事务:**
    1. ***关于事务的基本知识(面试知识)***:
        * 什么是事务;
        * 事务的四大特性ACID;
        * 不考虑隔离性会产生的3个问题;
        * 解决办法: 四种隔离级别.
    2. ***mybatis中的事务***:
        * 它是通过sqlsession对象的commit方法和rollback方法实现事务的提交和回滚.
    3. ***mybatis自动提交事务的设置***:
        * 为什么CUD过程中必须使用sqlSession.commit()提交事务? 主要原因就是在连接池中取出的连接都会将调用connection.setAutoCommit(false)方法, 这样我们就必须使用sqlSession.commit()方法, 相当于使用了JDBC中的connection.commit()方法实现事务提交.
        * 如图所示, 设置为自动提交事务:
        ![](D:\ssm框架-figure\23.png)

#### 2. mybatis事务控制的分析

## 第九章 Mybatis基于XML配置的动态SQL语句使用(会用即可)

mappers配置文件中的几个标签:

1. `<if>`
2. `<where>`
3. `<foreach>`
4. `<sql>`

## 第十章 Mybatis中的多表操作(掌握应用)

* 本次案例主要以最为简单的用户和账户的模型来分析Mybatis多表关系. 用户为User表, 账户为Account表. 一个用户可以有多个账户. 一个账户只能属于一个用户(多个账户也可以属于同一个用户).
* 步骤:
    1. 建立两张表: 用户表, 账户表. 
        * 让用户表和账户表之间具备一对多的关系: 需要使用外键在账户表中添加.
    2. 建立两个实体类: 用户实体类和账户实体类.
        * 让用户和账户的实体类能体现出来一对多的关系.
    3. 建立两个配置文件: 用户配置文件, 账户配置文件.
    4. 实现配置:
        * 当我们查询用户时, 可以同时得到用户下所包含的账户信息.
        * 当我们查询账户时, 可以同时得到账户的所属用户信息.

#### 1. 一对多

* **需求：**
    * 查询所有用户信息及用户关联的账户信息。
* **分析：**
    * 用户信息和他的账户信息为一对多关系，并且查询过程中如果用户没有账户信息，此时也要将用户信息查询出来，左外连接查询比较合适。

#### 2. 多对一
* Mybatis中把多对一看成了一对一.

#### 3. 一对一

#### 4. 多对多
* 多对多关系其实看成是双向的一对多关系。
* **实例：**用户和角色
    * 一个用户可以有多个角色；
    * 一个角色可以赋予多个用户。
* **步骤：**
    1. 建立两张表：用户表和角色表。让用户表和角色表具有多对多的关系。需要使用***中间表***，<u>中间表中包含各自的主键，在中间表中是外键</u>。
    2. 建立两个实体类：用户实体类和角色实体类。让用户和角色的实体类体现出来多对多的关系，<u>各自包含对方一个集合引用</u>。
    3. 建立两个配置文件：用户的配置文件和角色的配置文件。
    4. 实现配置：
        * 当查询用户时，可以同时得到用户所包含的角色信息；
        * 当查询角色时，可以同时得到角色的所赋予的用户信息。


## 第十一章 JNDI数据源

#### 1. JNDI概述和原理

* **概述：**
    * JNDI：java naming and directory interface（java命名和目录接口）。是sun公司推出的一套规范，属于javaEE技术之一。目的是模仿windows系统中的注册表。
* **原理：**
![](D:\ssm框架-figure\24.png)

#### 2. 在服务器中注册数据源

* **创建maven的war工程并导入坐标**
* **在webapp文件下创建META-INF目录**
* **在META-INF目录中建立一个名为context.xml的配置文件**
* **修改SqlMapConfig.xml中的配置**


## 第十二章 Mybatis延迟加载策略


## 第十三章 Mybatis缓存


## 第十四章 Mybatis注解开发


## 第十五章 Mybatis课程总结