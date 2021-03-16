#### 一. 对JDBC本质的理解

**1. [JDBC是什么?]()**

* `Java DataBase Connectivity `(Java语言连接数据库)

**2. [JDBC的本质是什么?]()**

* JDBC是SUN公司制定的一套**接口(interface)**, `java.sql.*;`(这个软件包下有很多接口). 接口都有调用者和实现者. 面向接口调用, 面向接口写实现类, 这都属于面向接口编程.
* 为什么要面向接口编程? 答: **解耦合**, 降低程序的耦合度, 提高程序的扩展力. 多态机制就是非常典型的面向抽象编程, 也就是面向父类型编程, 不要面向具体编程.

**3. [为什么SUN制定一套JDBC接口呢?]()**

![](D:\JDBC-figure\1.png)

* 因为**每一个数据库的底层实现原理都不一样**. Oracle数据库有自己的原理. MYSQL数据库也有自己的原理. MS SqlServer数据库也有自己的原理. ... 每一个数据库产品都有自己独特的实现原理.
* **Java程序员面向JDBC接口写代码**, **各个数据库厂家的Java程序员负责编写JDBC接口的实现类**.
* 图片中左边部分的class文件是自己要写的, 图片中间部分的class文件在`java.sql`包下, 图片右边部分的class文件需要从网上下载.

**4. [JDBC的本质到底是什么?]()**

* **一套接口**.



#### 二. 编写程序模拟JDBC本质

* 一共有三个角色: 我们(角色)是这套接口的调用者; SUN角色是这套接口的指定者; 数据库厂家(角色)是这套接口的实现者.

* **SUN角色** :

  ```java
  /*
  SUN公司负责制定这套JDBC接口.
  */
  public interface JDBC {
      /*
      	连接数据库的方法.
      */
      void getConnection();
  }
  ```

* **数据库厂家(角色)**(以mysql为例) :

  ```java
  /*
  MYSQL的数据库厂家负责编写JDBC接口的实现类
  */
  public class MYSQL implements JDBC {
      
      public void getConnection() {
          //具体这里的代码怎么写, 对于我们java程序员来说没关系
          //这段代码涉及到mysql底层数据库的实现原理.
          System.out.println("连接MYSQL数据库成功!");
      }
  }
  
  //实现类被称为驱动. (MYSQL驱动)
  //xxx.jar : 当中有很多.class, 都是对JDBC接口进行的实现.
  ```

* **我们(角色)**(java程序员) :

  ```java
  /*
  Java程序员角色.
  不需要关心具体是哪个品牌的数据库, 只需要面向JDBC接口写代码.
  面向接口编程, 面向抽象编程, 不要面向具体编程.
  */
  public class JavaProgrammer {
      
      public static void main(String[] args) throws Exception {
          //JDBC jdbc = new MYSQL();
          //JDBC jdbc = new Oracle();
          
          //创建对象可以通过反射机制.
          ResourceBundle bundle = ResourceBundle.getBundle("jdbc"); //jdbc.properties(配置文件: className=Oracle)
          String className = bundle.getString("className");
          Class c = Class.forName(className); //
          JDBC jdbc = (JDBC)c.newInstance();
          
          //以下代码都是面向接口调用方法, 不需要修改
          jdbc.getConnection();
      }
  }
  ```



#### 三. 将驱动jar配置到环境变量classpath中

* JDBC开发前的准备工作, 先从官网上下载对应的驱动jar包, 然后将其配置到环境变量classpath当中.
* 该配置是针对于文本编辑器的方式开发, 使用IDEA工具的时候, 不需要配置该环境变量. IDEA有自己的配置方式.



#### 四. JDBC编程六步(需要背会)

**1. [JDBC编程六步的概述]()**

* 第一步: **注册驱动** (作用: 告诉java程序, 即将要连接的是哪个品牌的数据库)
* 第二步: **获取连接** (表示JVM的进程和数据库进程之间的通道打开了. 这属于进程之间的通信, 重量级的, 使用完之后一定要关闭通道.)
* 第三步: **获取数据库操作对象** (专门执行sql语句的对象)
* 第四步: **执行SQL语句** (DQL, DML, ...)
* 第五步: **处理查询结果集** (只有当第四步执行的是select语句的时候, 才有这第五步处理查询结果集.)
* 第六步: **释放资源** (使用完资源之后一定要关闭资源. java和数据库数据进程间的通信, 开启之后一定要关闭.)

**2. [JDBC编程六步的代码实现(增添操作)]()**

```java
/*
	JDBC编程六步
*/
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Statement;

public class JDBCTest01 {
    public static void main(String[] args) {
        Statement stmt = null;
        Connection conn = null;
        try {
            //1. 注册驱动
            Driver driver = new com.mysql.jdbc.Driver(); //多态, 父类型引用指向子类型对象.
            //Driver driver = new oracle.jdbc.driver.OracleDriver(); //Oracle的驱动
            DriverManager.registerDriver(driver);
            
            //2. 获取连接
            /*
            	url: 统一资源定位符(网络中某个资源的绝对路径)
            	https://www.baidu.com/  这就是url.
            	
            	url包括哪几部分?
            		协议, IP, PORT, 资源名
            		
            	http://182.61.200.7:80/index.html
            		http:// 通信协议
            		182.61.200.7 服务器IP地址
            		80 服务器上软件的端口
            		index.html 是服务器上某个资源名
            		
            	说明: localhost和127.0.0.1都是本机IP地址.
            	
            	什么是通信协议, 有什么用?
            		通信协议是通信之前就提前定好的数据传送格式.
            		数据包具体怎么传数据, 格式提前定好的.
            		
            	Oracle的url:
            		jdbc:oracle:thin:@localhost:1521:orcl
            */
            //String url = "jdbc:mysql://ip:port/数据库名字";
            String url = "jdbc:mysql://127.0.0.1:3306/bjpowerndoe";
            //String user = "用户名";
            String user = "root";
            //String password = "密码";
            String password = "333";
            conn = DriverManager.getConnection(url, user, password);
            
            //3. 获取数据库操作对象(Statement专门执行sql语句的)
            stmt = conn.createStatement();
            
            //4. 执行sql
            String sql = "insert into dept(deptno,dname,loc) values(50,'人事部','北京')";
            //专门执行DML语句的(intsert delete update)
            //返回值是"影响数据库中的记录条数"
            int count = stmt.executeUpdate(sql);
            System.out.println(count == 1 ? "保存成功" : "保存失败");
            
            //5. 处理查询结果集
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            
            //6. 释放资源
            //为了保证资源一定释放, 在finally语句块中关闭资源
            //并且要遵循从小到大依次关闭
            //分别对其try...catch...
            //注意: 要分开try
            try {
                if(stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
```

**3. [JDBC执行删除和更新(删除和修改操作)]()**

```java
/*
	JDBC完成delete update
*/
public class JDBCTest02 {
    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try {
            //1. 注册驱动
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取数据库操作对象
            stmt = conn.createStatement();
            //4. 执行SQL语句
            //JDBC中的sql语句不需要提供分号结尾, 写上就会报错.
            //String sql = "delete from dept where deptno = 40";
            String sql = "update dept set dname = '销售部', loc = '天津' where deptno = 20";
            int count = stmt.executeUpdate(sql);
            System.out.println(count == 1 ? "删除成功" : "删除失败");
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if(stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

**4. [类加载的方式注册驱动]()**

```java
/*
	注册驱动的另一种方式(这种方式常用)
*/
public class JDBCTest03 {
    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try {
            //1. 注册驱动
            //这是注册驱动的第一种写法
            //DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            //注册驱动的第二种方式: 常用的.
            //为什么这种方式常用? 因为参数是一个字符串, 字符串可以写到xxx.properties文件中.
            //以下方法不需要接收返回值, 因为我们只想用它的类加载动作.
            Class.forName("com.mysql.jdbc.Driver");
            
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            System.out.println(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
```

* `com.mysql.jdbc.Driver`的代码:

  ![](D:\JDBC-figure\2.png)

**5. [从属性资源文件中读取连接数据库信息]()** :

```java
//将连接数据库的所有信息配置到配置文件中
//实际开发中不建议把连接数据库的信息写死到java程序中.
public class JDBCTest02 {
    public static void main(String[] args) {
        
        //使用资源绑定器绑定属性配置文件
        ResourceBundle bundle = ResourceBundle.getBundle("jdbc");
        String driver = bundle.getString(driver);
        String url = bundle.getString(url);
        String user = bundle.getString(user);
        String password = bundle.getString(password);
        
        Connection conn = null;
        Statement stmt = null;
        try {
            //1. 注册驱动
            Class.forName(driver);
            //2. 获取连接
            conn = DriverManager.getConnection(url, root, password);
            //3. 获取数据库操作对象
            stmt = conn.createStatement();
            //4. 执行SQL语句
            String sql = "update dept set dname = '销售部', loc = '天津' where deptno = 20";
            int count = stmt.executeUpdate(sql);
            System.out.println(count == 1 ? "修改成功" : "修改失败");
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if(stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

* `jdbc.properties配置文件`:
  * driver=com.mysql.jdbc.Driver
  * url=jdbc:mysql://localhost:3306/bjpowernode
  * user=root
  * password=333

**6. [处理查询结果集(查询操作)]()**

```java
/*
	处理查询结果集(遍历结果集)
*/
public class JDBCTest05 {
    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取数据库操作对象
            stmt = conn.createStatement();
            //4. 执行sql
            String sql = "select empno a, ename, sal from emp";
            //int executeUpdate(insert/delete/update)
            //ResultSet executeQuery(select)
            rs = stmt.executeQuery(sql); //专门执行DQL语句的方法
            //5. 处理查询结果集
            //注意: RsultSet不是平常的Set集合, 近似而已.
            //如果next()返回值为true, 则光标指向的行有数据, next()方法时ResultSet中的一个方法
            //取数据使用getString()方法, 该方法是ResultSet中的一个方法
            //getString()方法的特点是: 不管数据库中的数据类型是什么, 都是以String的形式取出.
            //JDBC中所有下标从1开始, 不是从0开始.
            while(rs.next()) {
                
                /*
                String empno = rs.getString(1);
                String ename = rs.getString(2);
                String sal = rs.getString(3);
                System.out.println(empno + "," + ename + "," + sal);
                */
                
                /*
                //这个不是以列的下标获取, 以列的名字获取
                //String empno = rs.getString("empno");
                String empno = rs.getString("a"); //重点注意: 列名称不是表中的列名称, 是查询结果集的列名称.
                String ename = rs.getString("ename");
                String sal = rs.getString("sal");
                System.out.println(empno + "," + ename + "," + sal);
                */
                
                //除了可以以String类型取出之外, 还可以以特定的类型取出.
                int empno = rs.getInt(1); 
                String ename = rs.getString(2);
                double sal = rs.getDouble(3);
                System.out.println(empno + "," + ename + "," + (sal + 100);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if(rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

* 处理查询结果集的示意图:

  ![](D:\JDBC-figure\3.png)

**7. [使用IDEA开发JDBC代码配置驱动]()**

* 往项目中导入jar包: 右键项目 -> 选择`Open Module Settings` -> 选择`Libraries` -> 点击加号添加jar包.



#### 五. 用户登录业务

**1. [实现功能]()**

* **需求** : 模拟用户登录功能的实现.

* **业务描述** : 程序运行的时候, 提供一个输入的入口, 可以让用户输入用户名和密码, 用户输入用户名和密码之后, 提交信息, java程序收集到用户信息, java程序连接数据库验证用户名和密码是否合法. 如果合法, 则显示登录成功; 如果不合法, 则显示登录失败.

* **数据的准备** : 在实际开发中, 表的设计会使用专业的建模工具, 我们这里安装一个建模工具: `PowerDesigner`. 使用该工具来进行数据库表的设计. (参见user-login.sql脚本)
* **当前程序存在的问题** : 
  * 用户名: fdsa
  * 密码: fdsa' or '1'='1
  * 登录成功
  * **这种现象被称为SQL注入(安全隐患).** (黑客经常使用)
* **导致SQL注入的根本原因是什么?** : 用户输入的信息中含有sql语句的关键字, 并且这些关键字参与sql语句的编译过程, 导致sql语句的原意被扭曲, 进而达到sql注入.

**2. [PowerDesigner工具]()**

* **使用PowerDeigner工具进行物理建模**

**3. [用户登录功能的代码实现]()**

```java
public class JDBCTest06 {
    public static void main(String[] args) {
        //初始化一个界面
        Map<String, String> userLoginInfo = initUI();
        //验证用户名和密码
        boolean loginSuccess = login(userLoginInfo);
        //最后输出结果
        System.out.println(loginSuccess ? "登录成功" : "登录失败");
    }
    
    /**
     * 用户登录
     * @param userLoginInfo 用户登录信息
     * @return false表示失败, true表示成功
     */
    private static boolean login(Map<String, String> userLoginInfo) {
        //打标记
        boolean loginSuccess = false;
        //单独定义变量
        String loginName = userLoginInfo.get("loginName");
        String loginPwd = userLoginInfo.get("loginPwd");
        
        //JDBC代码
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取数据库操作对象
            stmt = conn.createStatement();
            //4. 执行sql
            String sql = "select * from t_user where loginName = '" + loginName + "' and loginPwd = '" + loginPwd + "'";
            //以上正好完成了sql语句的拼接, 以下代码的含义是: 发送sql语句给DBMS, DBMS进行sql编译.
            //正好将用户提供的"非法信息"编译进去, 导致了原sql语句的含义被扭曲了.
            rs = stmt.executeQuery(sql);
            //5. 处理结果集
            if(rs.next()) {
                //登录成功
                loginSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if(rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return loginSuccess;
    }
    
    /**
     * 初始化用户界面
     * @return 用户输入的用户名和密码等登录信息
     */
    private static Map<String, String> initUI() {
        Scanner s = new Scanner(System.in);
        
        System.out.println("用户名: ");
        String loginName = s.nextLine();
        
        System.out.println("密码: ");
        String loginPwd = s.nextLine();
        
        Map<String, String> userLoginInfo = new HashMap<>();
        userLoginInfo.put("loginName", loginName);
        userLoginInfo.put("loginPwd", loginPwd);
        
        return userLoginInfo;
    }
}
```

**4. [演示SQL注入现象]()**

* 上面代码存在SQL注入问题.

**5. [解决SQL注入问题(PreparedStatement的查询操作)]()**

```java
/**
 * 1. 解决SQL注入问题:
 *        只要用户提供的信息不参与SQL语句的编译过程, 问题就解决了.
 *		  即使用户提供的信息中含有SQL语句的关键字, 但是没有参与编译, 不起作用.
 * 		  要想用户信息不参与SQL语句的编译, 那么必须使用java.sql.PreparedStatement.
 * 2. PreparedStatement的介绍:
 *        PreparedStatement接口继承了java.sql.Statement.
 *		  PreparedStatement是属于预编译的数据库操作对象.
 *        PreParedStatement的原理是: 预先对SQL语句的框架进行编译, 然后再给SQL语句传"值".
 * 3. 测试结果:
 * 		  用户名: fdas
 * 		  密码: fdsa' or '1'='1
 * 		  登录失败
 * 4. 解决SQL注入的关键是什么?
 * 		  用户提供的信息中即使含有sql语句的关键字, 但是这些关键字并没有参与编译, 不起作用.
 */
public class JDBCTest07 {
    public static void main(String[] args) {
        //初始化一个界面
        Map<String, String> userLoginInfo = initUI();
        //验证用户名和密码
        boolean loginSuccess = login(userLoginInfo);
        //最后输出结果
        System.out.println(loginSuccess ? "登录成功" : "登录失败");
    }
    
    /**
     * 用户登录
     * @param userLoginInfo 用户登录信息
     * @return false表示失败, true表示成功
     */
    private static boolean login(Map<String, String> userLoginInfo) {
        //打标记
        boolean loginSuccess = false;
        //单独定义变量
        String loginName = userLoginInfo.get("loginName");
        String loginPwd = userLoginInfo.get("loginPwd");
        
        //JDBC代码
        Connection conn = null;
        PreparedStatement ps = null; //这里使用PreparedStatement(预编译的数据库操作对象)
        ResultSet rs = null;
        
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取预编译数据库操作对象
            //SQL语句的框子. 其中一个?, 表示一个占位符, 一个?将来接收一个"值", 注意: 占位符不能使用单引号括起来.
            String sql = "select * from t_user where loginName = ? and loginPwd = ?"; 
            //程序执行到此处, 会发送sql语句框子给DBMS, 然后DBMS进行sql语句的预先编译.
            ps = conn.prepareStatement(sql);
            //给占位符?传值 (第1个问号下标是1, 第2个问号下标是2, JDBC中所有下标从1开始.)
            ps.setString(1, loginName);
            ps.setString(2, loginPwd);
            //4. 执行sql
            rs = ps.executeQuery();
            //5. 处理结果集
            if(rs.next()) {
                //登录成功
                loginSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if(rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(ps != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if(conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return loginSuccess;
    }
    
    /**
     * 初始化用户界面
     * @return 用户输入的用户名和密码等登录信息
     */
    private static Map<String, String> initUI() {
        Scanner s = new Scanner(System.in);
        
        System.out.println("用户名: ");
        String loginName = s.nextLine();
        
        System.out.println("密码: ");
        String loginPwd = s.nextLine();
        
        Map<String, String> userLoginInfo = new HashMap<>();
        userLoginInfo.put("loginName", loginName);
        userLoginInfo.put("loginPwd", loginPwd);
        
        return userLoginInfo;
    }
}
```



#### 六. Satement和PreparedStatement

**1. [Satement和PreparedStatement对比(三个方面的不同)]()**

1. **SQL注入** : Statement存在sql注入问题, PreparedStatement解决了SQL注入问题.
2. **效率** : Statement是编译一次执行一次, PreparedStatement是编译一次, 可执行N次. PreparedStatement效率较高.
3. **安全** : PreparedStatement会在编译阶段做类型的安全检查.

综上所述: PreparedStatement使用较多. 只有极少数的情况下需要使用Statement.

**2. [什么情况下必须使用Statement呢?]()**

* 业务方面要求必须支持SQL注入的时候.
* Statement支持SQL注入, 凡是业务方面要求是需要进行sql语句拼接的, 必须使用Statement.

**3. [演示Statement的用途]()**

```java
public class JDBCTest08 {
    public static void main(String[] args) {
        //用户在控制台输入desc就是降序, 输入asc就是升序
        Scanner s = new Scanner(System.in);
        System.out.println("输入desc或asc, desc表示降序, asc表示升序");
        System.out.print("请输入: ");
        String keyWords = s.nextLine();
        
        //执行SQL
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取数据库操作对象
            stmt = conn.createStatement();
            //4. 执行SQL
            String sql = "select ename from emp order by ename " + keyWords;
            rs = stmt.executeQuery(sql);
            //5. 遍历结果集
            while(rs.next()) {
                System.out.println(rs.getString("ename"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

**4. [PreparedStatement的增删改操作]()**

```java
/**
 * PreparedStatement完成INSERT DELETE UPDATE
 */
public class JDBCTest09 {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取预编译数据库操作对象
            //增添操作
            /*
            String sql = "insert into dept(deptno,dname,loc) values(?,?,?)"; 
            ps = conn.prepareStatement(sql);
            ps.setInt(1, 60);
            ps.setString(2, "销售部");
            ps.setString(3, "上海");
            */
            //修改操作
            /*
            String sql = "update dept set dname = ?, loc = ? where deptno = ?"; 
            ps = conn.prepareStatement(sql);
            ps.setString(1, "研发一部");
            ps.setString(2, "北京");
            ps.setInt(3, 60);
            */
            //删除操作
            String sql = "delete from dept where deptno = ?"; 
            ps.setInt(1, 60);
            //4. 执行sql
            int count = ps.executeUpdate();
            System.out.println(count);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```



#### 七. JDBC事务机制

**1. [JDBC的事务自动提交机制的演示]()**

```java
/**
 * JDBC事务机制:
 *     1. JDBC中的事务是自动提交的, 什么是自动提交?
 *         只要执行任意一条DML语句, 则自动提交一次, 这是JDBC默认的事务行为.
 *         但是在实际的业务当中, 通常都是N条DML语句共同联合才能完成的, 
 *         必须保证他们这些DML语句在同一个事务中同时成功或者同时失败.
 *     2. 以下程序先来验证以下JDBC的事务是否是自动提交机制.
 *         测试结果, JDBC中只要执行任意一条DML语句, 就提交一次.
 */
public class JDBCTest10 {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //3. 获取预编译数据库操作对象
            String sql = "update dept set dname = ? where deptno = ?";
            ps = conn.prepareStatement(sql);
            
            //第一次给占位符传值
            ps.setString(1, "x部门");
            ps.setInt(2, 30);
            int count = ps.executeUpdate(); //执行第一条update语句
            System.out.println(count);
            
            //重新给占位符传值
            ps.setString(1, "y部门");
            ps.setInt(2, 20);
            count = ps.executeUpdate(); //执行第二条update语句
            System.out.println(count);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```

**2. [账户转账演示业务]()**

```java
/**
 * sql脚本:
 *     drop table if exists t_act;
 *     create table t_act(
 *         actno int,
 *         balance double(7, 2) //注意: 7表示有效数字的个数, 2表示小数位的个数
 *     );
 *     insert into t_act(actno, balance) values(111, 20000);
 *     insert into t_act(actno, balance) values(222, 0);
 *     commit;
 *     select * from t_act;
 * 
 * 重点三行代码:
 *     conn.setAutoCommit(false); //开启事务
 *     conn.commit(); //提交事务
 *     conn.rollback(); //回滚事务
 */
public class JDBCTest11 {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            //1. 注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获取连接
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
            //将自动提交机制修改为手动提交
            conn.setAutoCommit(false); //开启事务
            
            //3. 获取预编译数据库操作对象
            String sql = "update t_act set balance = ? where actno = ?";
            ps = conn.prepareStatement(sql);

            //给?传值
            ps.setDouble(1, 10000);
            ps.setInt(2, 111);
            int count = ps.executeUpdate();

            String s = null;
            s.toString();

            //给?传值
            ps.setDouble(1, 10000);
            ps.setInt(2, 222);
            count += ps.executeUpdate();

            System.out. println(count == 2 ? "转账成功" : "转账失败");
            
			//程序能够走到这里说明以上程序没有异常, 事务结束, 手动提交数据
            conn.commit(); //提交事务
            
        } catch (Exception e) {
            //回滚事务
            if(conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            //6. 释放资源
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
```



#### 八. JDBC工具类的封装

**1. [JDBC工具类的封装]()**

```java
/**
 * JDBC工具类, 简化JDBC编程.
 */
public class DBUtil {
    
    /**
     * 工具类中的构造方法都是私有的.
     * 因为工具类当中的方法都是静态的. 不需要new对象, 直接采用类名调用.
     */
    private DBUtil() {}
    
    //静态代码块在类加载时执行, 并且只执行一次.
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 获取数据库连接对象
     * @return 连接对象
     * @throws SQLException
     */
    public static Collection  getCollection() throws SQLException {
        return DriverManager.getCollection("jdbc:mysql://localhost:3306/bjpowernode", "root", "333");
    }
    
    /**
     * 关闭资源
     * @param conn 连接对象
     * @param ps 数据库操作对象
     * @param rs 结果集
     */
    public static void close(Connection conn, Statement ps, ResultSet rs) {
        if(rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
```

**2. [使用JDBC工具类实现模糊查询]()**

```java
/**
 * 这个程序有两个任务:
 *     第一: 测试DBUtil是否好用
 *     第二: 模糊查询怎么写?
 */
public class JDBCTest12 {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            //获取连接
            conn = DBUtil.getConnection();
            //获取预编译的数据库操作对象
            
            //错误写法
            /*
            String sql = "select ename from emp where ename like '_?%'";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "A");
            */
            
            String sql = "select ename from emp where ename like ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "_A%");
            rs = ps.executeQuery();
            while(rs.next()) {
                System.out.println(rs.getString("ename"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }
}
```



#### 九. 行级锁

![](D:\JDBC-figure\4.png)

**1. [乐观锁]()**

* 支持并发, 事务也不需要排队, 只不过需要一个版本号.

**2. [悲观锁(行级锁)]()**

* 事务必须排队执行. 数据锁住了, 不允许并发. (**行级锁: select后面添加for update**)

**3. [演示行级锁机制]()**

```java
/**
 * 这个程序开启一个事务, 这个事务专门进行查询, 并且使用行级锁/悲观锁, 锁住相关的记录.
 */
public class JDBCTest13 {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        RrsultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            //开启事务
            conn.setAutoCommit(false);
            
            String sql = "select ename, job, sal from emp where job = ? for update";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "MANAGER");
            
            rs = ps.executeQuery();
            while(rs.next()) {
                System.out.println(rs.getString("ename") + "," + rs.getString("job") + "," + rs.getDouble("sal"));
            }
            //提交事务(事务结束)
            conn.commit();
        } catch (SQLException e) {
            if(conn != null) {
                try {
                    //回滚事务(事务结束)
                    conn.rolback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    } 
}
```

```java
/**
 * 这个程序负责修改被锁定的记录.
 */
public class JDBCTest14 {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            String sql = "update emp set sal = sal * 1.1 where job = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "MANAGER");
            int count = ps.executeUpdate();
            System.out.println(count);
            
            //提交事务(事务结束)
            conn.commit();
        } catch (SQLException e) {
            if(conn != null) {
                try {
                    //回滚事务(事务结束)
                    conn.rolback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, null);
        }
    } 
}
```