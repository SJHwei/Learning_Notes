#  Java入门

#### 1. Java程序的加载与执行

![](D:\Java-figure\2.png)

​		java程序的整个执行过程分为两个阶段: 编译和运行. 编译阶段通过javac命令将`.java`文件编译成`.class`文件(字节码文件, 但是不是纯粹的二进制文件); 运行阶段通过java命令启动java虚拟机, 虚拟机启动`类装载器`, 将`.class`文件装载到JVM中, JVM将该字节码文件解释成二进制数据, 然后操作系统执行二进制和底层硬件平台进行交互.

​		编译和运行可以在两个操作系统上完成, 这就是java的跨平台.

​		java程序最终是运行在java虚拟机上的.

#### 2. JVM, JRE, JDK的关系

* JDK为开发工具包, 开发人员使用. 一般JDK中都会自带一个JRE.
* JRE可以运行java程序. 一般给用户安装JRE. 安装JRE表示不在这台电脑上开发, 只在这台电脑上运行java程序.
* 由于java程序最终运行在java虚拟机上, 所以JRE包括java虚拟机.

* 关系图 : 

  ![](D:\Java-figure\3.png)

#### 3. Java虚拟机内存管理

![](D:\Java-figure\4.png)

* 方法区中存储的是`.class`文件的代码, 还存储了静态变量和常量.

* 除了这三个区, 还有其他区. (推荐书 : 深入java虚拟机第二版, 第五章)

* 垃圾回收机制 :

  ![](D:\Java-figure\5.png)

#### 4. Java文档注释

* Java支持三种注释方式 : 
  1. 单行注释 : `//......`
  2. 块注释 : `/*......*/`
  3. 文档注释 : `/**......*/`, 说明(文档)注释允许你在程序中嵌入关于程序的信息. 可以使用javadoc工具软件来生成信息, 并输出到HTML文件中.
* javadoc标签(javadoc工具软件识别以下标签) : 
  * @author : 对类的说明, 标识一个类的作者;
  * @version : 对类的说明, 指定类的版本;
  * @see : 对类, 属性, 方法的说明, 指定一个到另一个主题的链接;
  * @param : 对方法的说明, 说明一个方法的参数;
  * @return : 对方法的说明, 说明返回值类型;
  * @exception : 对类, 方法的说明, 标志一个类或方法抛出的异常.
* javadoc输出什么 : 
  * javadoc工具将java程序的源代码作为输入, 输出一些包含程序注释的HTML文件. 每一个类的信息将在独自的HTML文件里. javadoc也可以输出继承的属性结构和索引. 



# 面向对象

#### 1. static关键字

* static修饰的变量叫做"静态变量" : 

  * 变量分类 : 局部变量; 成员变量(实例变量, 非静态变量); 静态变量(方法区).

  * 成员变量在创建java对象的时候初始化; 静态变量在类加载阶段赋值, 并且只赋值一次.

  * 静态变量被存储在方法区, 所有的java对象共享这一份, 节省了内存. 所以静态变量是类级别的, 使用"类名."的方式访问.

  * 静态变量也可以使用`引用.`访问, 但是静态变量底层访问的时候一定使用的`类名.`, 和对象无关, 不会出现空指针异常.

  * 如何访问?

    * `类名.`
    * 也可以使用`引用.`

  * 什么时候变量声明成静态变量?

    * 如果这个属性所有的对象都有, 并且这个属性的值时相同的, 则该属性声明为静态的属性.

  * 实例 :

    ![](D:\Java-figure\8.png)

    ![](D:\Java-figure\7.png)

    ![](D:\Java-figure\9.png)

    ![](D:\Java-figure\10.png)

* static修饰的方法叫做"静态方法" : 

  * 一般情况下工具类中的方法大部分都是静态方法;
  * 静态方法不用创建对象也能直接访问该方法, 成员方法必须使用`引用.`调用, 静态方法使用`类名.`方式调用. 
  * 静态方法也能用`引用.`访问, 但是注意 : 编译阶段检查出当前对象是这个类类型, 编译通过, 运行的时候, 仍然使用`类名.`的方式访问, 当前对象的该方法执行不需要对象.
  * 静态方法不能直接访问非静态数据, 静态方法不能使用`this`关键字.
  * `空指针异常` : 空的引用去访问成员的时候回出现空指针异常, 但是如果空的引用去访问静态方法则不会出现空指针异常, 因为底层还是使用`类名.`方式访问的.

* static还可以定义静态语句块 : 

  ![](D:\Java-figure\6.png)

  * `static定义的静态语句块在类加载阶段执行, 并且只执行一次. 并且是自上而下的顺序执行.`

  * 关于实例语句块 :

    * 每一次调用构造方法之前会执行一次;
    * 实例语句块执行顺序也是自上而下.

    ![](D:\Java-figure\12.png)

* 一个类中含有 : 

  * 成员变量;
  * 成员方法;
  * 静态变量;
  * 静态方法;
  * 静态语句块;
  * 实例语句块;
  * 构造方法;
  * this;

* 关于代码的顺序(非法向前引用) : 成员变量和成员方法不受顺序影响; 静态变量和静态方法受顺序影响, 因为它们是在类加载阶段执行.

  ![](D:\Java-figure\11.png)

#### 2. 抽象类

* 如何定义抽象类?
  * class关键字前加`abstract`.
* 抽象类`无法被实例化`.
* 虽然抽象类没有办法被实例化, 但是抽象类也有构造方法, 该构造方法是给子类创建对象用的. 父类的构造方法虽然调用了, 但是并没有创建父类对象.

* 抽象类中可以定义抽象方法. 抽象方法的语法 : 在方法的修饰符列表中添加`abstract`关键字, 并且抽象方法应该以`;`结束, 不能带有`{}`.

* `抽象类中不一定有抽象方法, 但抽象方法必须出现在抽象类中.`

* 一个非抽象类继承抽象类, 必须将抽象类中的抽象方法`覆盖, 实现, 重写`.

#### 3. 接口

* 接口也是一种引用类型, 可以等同看做类.

  * 如何定义接口, 语法 : `[修饰符] interface 接口名 {}`
  * 接口中只能出现 : `常量(必须用public static final修饰), 抽象方法(用public abstarct修饰)`
  * `注意` : `public static final`是可以省略的. `public abstract`是可以省略的.
  * 接口其实是一个特殊的抽象类, 特殊在接口是`完全抽象`的
  * 接口中`没有构造方法`, `无法被实例化`
  * 接口和接口之间可以`多继承`
  * `一个类可以实现多个接口`. (这里的"实现"可以等同看做"继承")
  * 一个非抽象的类实现接口, 需要将接口中`所有方法`"实现/重写/覆盖".

  * 一个类要实现接口, 必须将`implements`关键字, 是实现的意思. `implements和extends意义相同`.

* 接口的作用 :

  1. 可以使项目分层, 所有层都面向接口开发, 开发效率提高了. (面向接口调用, 面向接口实现)

     ![](D:\Java-figure\13.png)

  2. 接口使代码和代码之间的耦合度降低, 就像内存条和主板的关系, 变得"可插拔". 可以随意切换.

  3. 生产汽车实例 : 

     ![](D:\Java-figure\14.png)

     ![](D:\Java-figure\15.png)

     ![](D:\Java-figure\16.png)

     ![](D:\Java-figure\17.png)

     ![](D:\Java-figure\18.png)

* 如果抽象类和接口都能满足需求, 优先选择接口. 因为接口可以多实现, 多继承. 并且一个类除了实现接口外, 还可以去继承其他类(保留了类的继承).

#### 4. Object类

* 类Object(`java.lang.Object`)是类层次结构的根类. 每个类都使用object作为超类. 所有对象(包括`数组`)都实现这个类的方法.

* Object类中常用的几个方法 : 

  1. `boolean equals(object obj)` : 指示其他某个对象是否与此对象"相等".

     ![](D:\Java-figure\252.png)

     * `==` 两边如果是引用类型, 则比较内存地址, 地址相同则是true, 反之则false. object中的equals方法比较的是两个引用的内存地址. java对象中的equals方法的设计目的是判断两个对象是否一样. 

     * object中的equals方法比较的是内存地址. 在现实的业务逻辑当中, 不应该比较内存地址, 应该比较内容. 所以object中的equals方法也要重写.

     * 关于java语言中如何比较两个字符串是否一致 : 在java中比较两个字符串是否一致, 不能用"==", 只能调用string类的equals方法. string已经重写了object中的equals方法, 比较的是内容. 

       ![](D:\Java-figure\251.png)

  2. `protected void finalize()` : 当垃圾回收器确定不存在对该对象的更多引用时, 由对象的垃圾回收器(GC)调用此方法.

     ![](D:\Java-figure\253.png)

     * finalize方法什么时候调用 :
       1. finalize方法每个java对象都有;
       2. finalize方法不需要程序员去调用, 由系统自动调用;
       3. java对象如果没有更多的引用指向它, 则该java对象成为垃圾数据, 等待垃圾回收器的回收, 垃圾回收器在回收这个java对象之前会自动调用该对象的finalize方法.
     * finalize方法是该对象马上就要被会回收了, 例如 : 需要释放资源, 则可以在该方法中释放. 程序员只能"建议"垃圾回收器回收垃圾.

  3. `int hashCode()` : 返回该对象的哈希吗值. java对象的内存地址经过哈希算法得出的int类型的数值.

  4. `String toString()` : SUN在object类中设计tostring方法的目的是返回java对象的字符串表示形式. 对于自己定义的类, 如果没有重写tostring方法, 则返回的是创建该类对象的引用, 也就是对象的存储地址. 在现实的开发过程中, object里边的tostring方法已经不够用了. 因为object的tostring方法实现的结果不满意. object中的tostring方法就是要被重写的.

     ![](D:\Java-figure\249.png)

     * print方法后面括号中如果是一个引用类型, 会默认调用引用类型的tostring方法.

     * object中的tostring方法返回 : `类名@对象的内存地址经过哈希算法得出的int类型值再转换成十六进制`. 这个输出结果可以等同看做java对象在堆中的内存地址.

       ![](D:\Java-figure\250.png)

  5. `protected Object clone()` : 创建并返回此对象的一个副本.

#### 5. 包和import

* 软件包机制 : 
  1. 为了解决类的`命名冲突`问题, 在类名前加`命名空间`(包机制);
  2. 在java中使用`package语句`定义包(单包, 复包);
  3. package语句只能出现在 .java 源文件的`第一行`;
  4. package定义的格式, 通常采用`公司域名倒叙方式`, 例如 : com.bjpowernode.oa.system, 以上包含义 : bjpowernode公司开发oa项目, system是oa项目中其中一个模块;
  5. package定义的全格式 : `公司域名倒叙.项目名.模块名`;
  6. `完整的类名是带有包名的`;
  7. 带有package语句的java源文件必须这样编译 : javac -d 生成路径 java源文件路径;
  8. 运行 : java com.bjpowernode.javase.day05.User.
  
  `注意` : com, bjpowernode, javase, day05都可以看成一个类. classpath表示所在的当前类. 
* import语句可以引入其他类, import语句只能出现在package语句之下, class定义的语句之上. 
* java.lang; 软件包下所有类不需要手动导入, 系统自动导入.
* JDK常用的开发包 : 
  * java.lang : java语言标准包;
  * java.sql : 提供了JDBC接口类;
  * java.util : 提供了常用工具类;
  * java.io : 提供了各种输入输出流.
  
* package为了分割空间, 虽然可以解决类的命名冲突问题, 但是想要在当前类中使用其他类时需要完整的类名(带有包名), 所以为了解决这个问题, 使用import导入其他类, 则在当前类中直接使用其他类即可, 不用加上很长的包名.

#### 6. 访问控制权限

* 关于访问控制权限修饰符(四种) : 修饰类, 修饰方法, 修饰变量.

  ![](D:\Java-figure\254.png)

  1. `private` : 只能在本类中访问;
  2. `default` : 可以在本类中, 同一个包下访问, 在不同包下不能访问;
  3. `protected` : 可以在本类中, 同一个包下访问, 在不同包下不能访问, 但是子类中可以;
  4. `public` : 可以在任何位置访问.

  `注意` : 类只能使用public或者缺省方式.

#### 7. 内部类

* 静态内部类 : 

  ![](D:\Java-figure\255.png)

  ![](D:\Java-figure\256.png)

  1. 静态内部类可以等同看做静态变量, 内部类重要的作用 : `可以访问外部类中私有的数据`.
  2. 静态内部类可以用访问控制权限的修饰符(四种)修饰.

  `注意` : 生成的内部类class文件的名字格式 : `外部类类名$内部类类名.class`.

  3. 静态内部类可以直接访问外部类的静态数据, 无法直接访问成员.

  4. 访问静态内部类使用`.`将外部类和内部类连接起来 : 

     ![](D:\Java-figure\257.png)

* 成员内部类  : 

  ![](D:\Java-figure\259.png)

  ![](D:\Java-figure\260.png)

  1. 成员内部类可以等同看做成员变量;

  2. 成员内部类中不能有静态声明;

  3. 成员内部类可以访问外部类所有的数据;

  4. 成员内部类可以用访问控制权限的修饰符修饰;

  5. 访问成员内部类的方式 : 

     ![](D:\Java-figure\258.png)

* 局部内部类 : 

  ![](D:\Java-figure\262.png)

  1. 局部内部类等同于局部变量;
  2. 重点 : `局部内部类在访问局部变量的时候, 局部变量必须使用final修饰`;
  3. `局部内部类不能使用访问控制权限修饰符修饰`, `内部类不能有静态声明`;

  `注意` : 创建局部内部类/调用局部内部类方法只能在方法内部进行, 因为是局部的.

  4. 访问局部内部类的方式 : 通过调用外部类的方法, 执行方法时访问内部类.

     ![](D:\Java-figure\261.png)

* 匿名内部类 : 

  ![](D:\Java-figure\263.png)

  ![](D:\Java-figure\264.png)

  1.  匿名内部类 : 指的是类没有名字.
  2. 匿名内部类的优点是少定义一个类; 缺点是无法重复使用.

#### 8. 类之间的关系

* 泛化关系 : 类和类之间的继承关系以及接口与接口之间的继承关系.

* 实现关系 : 类对接口的实现.

* 关联关系 : 类与类之间的连接, 一个类可以知道另一个类的属性和方法, 在java语言中使用成员变量体现.

  * 在当前类中含有其他类的引用, 在当前对象中含有指向其他对象的引用.

* 聚合关系 : 是关联关系的一种, 是较强的关联关系, 是整体和部分的关系. 它与关联关系不同, 关联关系的类处在同一个层次上, 而聚合关系的类处在不平等的层次上, 一个代表整体, 一个代表部分, 在java语言中使用实例变量体现.

  ![](D:\Java-figure\265.png)

  ![](D:\Java-figure\266.png)

  * 聚合关系特点 : 整体不依赖部分, 部分也不会依赖整体. 整体无法决定部分的声明周期.
  * 聚合关系强调一对多, 而关联关系可以一对一.

* 合成关系 : 是关系的一种, 比聚合关系强的关联关系. 整体对象决定部分对象的生命周期, 部分对象每一时刻只与一个对象发生合成关系, 在java语言中使用实例变量体现.

  ![](D:\Java-figure\267.png)

  * 合成关系和聚合关系是相似的, 区别的地方在于 : 整体和部分是紧密相连的, 整体的生命周期决定部分的生命周期.

* 依赖关系 : 依赖关系是比关联关系弱的关系, 在java语言中体现为返回值, 参数, 局部变量和静态方法调用.

  ![](D:\Java-figure\268.png)

  ![](D:\Java-figure\269.png)

#### 9. 类的继承

* java语言中子类继承父类, 会将父类中所有的数据全部继承, 包括私有的也能继承过来. 但是在子类中无法直接访问父类中的私有的数据, 但是可以间接访问(通过方法).
* `注意` : 构造方法无法被子类继承.
* 方法的覆盖(override / 重写) : 
  1. 发生方法重写的条件 : 
     * 第一 : 发生在具有继承关系的两个类之间;
     * 第二 : 必须具有相同的方法名, 相同的返回值类型, 相同的参数列表;
     * 第三 : `重写的方法不能比被重写的方法拥有更低的访问权限`;
     * 第四 : `重写的方法不能比别重写的方法抛出更宽泛的异常`;
     * 第五 : `私有方法`不能被覆盖;
     * 第六 : `构造方法`无法被覆盖, 因为构造方法无法被继承;
     * 第七 : `静态方法`不存在覆盖, 因为静态方法执行和对象无关;
     * 第八 : 覆盖指的是成员方法, 和成员变量无关.
  2. 继承最基本的作用 : 代码重用; 继承最重要的作用 : 方法可以重写.

#### 10. 多态

* 关于java语言中向上转型和向下转型 : 

  1. 向上转型(upcasting) : 子 --> 父

     ![](D:\Java-figure\270.png)

     * 向上转型又被称作`自动类型转换`, `父类型的引用指向子类型对象`.
     * 程序分为两个阶段 : 编译阶段和运行阶段. 
       * `Animal a1 = new Cat()` : 程序编译阶段只知道a1是一个animal类型, 程序在运行的时候堆中的实际对象是cat对象. 
       * `a1.eat()` : 程序在编译阶段a1被编译器看做animal类型, 所以程序在编译阶段a1引用绑定的是animal类中的eat方法(静态绑定). 程序在运行的时候堆中的对象实际上是cat类型, 而cat已经重写了eat方法, 所以程序在运行阶段对象的绑定的方法是cat中的eat方法(动态绑定). 

  2. 向下转型(downcasting) : 父 --> 子

     ![](D:\Java-figure\271.png)

     * 向下转型 : 强制类型转换.

     * 当前父类型引用指向了子类型对象, 要想执行子类中特有的方法怎么做 : 只能强制类型转换, 需要加强制类型转换符.

     * 在做强制类型转换的时候程序是存在风险的! 为了避免`ClassCastException`的发生, java引入了`instanceof` : 

       ![](D:\Java-figure\272.png)

       * instanceof的用法 : 
         1. instanceof运算符的运算结果是boolean类型
         2. 格式 : (引用 instanceof 类型) --> true/false
       * 例如 : (a instanceof Cat) 如果结果是true表示a引用指向堆中的java对象是Cat类型.

     * 推荐 : 在做向下转型的时候要使用instanceof运算符判断, 避免classcastexception.

  `注意` : 无论是向上转型还是向下转型, 两个类之间必须要有`继承关系`.
  
* 尽量不要面向具体编程, 面向父类型编程, 面向抽象编程.

* 多态作用 :

  1. 使用多态可以使代码之间的耦合度降低;
  2. 项目的扩展能力增强. 

#### 11. super关键字

1. super不是引用类型, super中存储的不是内存地址, super指向的不是父类对象;

2. super代表的是当前子类对象中的父类型特征.

   ![](D:\Java-figure\273.png)

3. 什么时候使用super?

   * 子类和父类中都有某个数据, 例如 : 子类和父类中都有name这个属性.
   * 如果要在子类中访问父类中的那么属性, 需要使用`super`.

4. super可以用在什么地方?

   * 第一 : super可以用在成员方法中, 不能用在静态方法中 : 

     * `注意` : this和super相同, 都不能用在静态上下文中.

   * 第二 : super可以用在构造方法中 : 

     * 语法 : `super(实参)`;

     * 作用 : `通过子类的构造方法去调用父类的构造方法`, 这样做的作用是`给当前子类对象中的父类型特征赋值`;

       ![](D:\Java-figure\274.png)

     * 语法规则 : `一个构造方法第一行如果没有this(...), 也没有显示的去调用super(...), 系统会默认调用super()`;

     * 注意 : super(...)的调用只能放在构造方法的第一行, super(...)和this(...)不能共存;

     * 注意 : super(...)调用了父类中的构造方法, 但是并`不会创建父类对象`;

     * 注意 : 构造方法执行不一定创建对象;

     * 单例模式的缺点 : 单例模式的类型无法被继承, 单例模式的类型没有子类, 无法被继承.

#### 12. final关键字

* final修饰的类无法被继承.
* final修饰的方法无法被覆盖.
* final修饰的局部变量, 一旦赋值, 不可再改变.
* final修饰的成员变量必须"显示的"初始化, final修饰的成员变量必须手动初始化.
* final修饰的成员变量一般和static连用, 因为如果只使用final, 则每个对象都有一份, 占用内存, 连用后就只有一份了, 节省内存. 连用后声明的成员的变量就成`常量`了, java规范中要求所有的常量"大写". 常量 : 值不可再改变的变量.
* 抽象类不能被final修饰, 抽象方法不能被final修饰.
* final修饰的引用类型, 该引用不可再重新指向其他的java对象. 但是final修饰的引用, 该引用指向的对象的属性是可以修改的.

#### 13. this关键字

1. this是什么？
   
   ![](D:\Java-figure\275.png)
   
   * this是一个引用类型
   * 在堆中的每一个java对象上都有this
   * this保存内存地址指向自身
   
2. this能用在哪些地方？
   * 第一：this可以用在`成员方法`中, this就是当前对象.

   * 第二：this可以用在`构造方法`中.

     ![](D:\Java-figure\278.png)

     * this用在构造方法中有一个新的语法 : `this(实参)`
     * 作用 : `通过一个构造方法去调用另一个构造方法`.
     * 目的 : 代码重用.
     * this(实参)必须出现在构造方法的`第一行`.

3. this可以用来区分成员变量和局部变量.

4. this不能用在静态方法中.

   ![](D:\Java-figure\277.png)

   ![](D:\Java-figure\276.png)

   * 静态方法的执行根本不需要java对象的存在. 直接使用`类名.`的方式访问. 而this代表的是当前对象. 所以静态方法中根本没有this. 
   * 如果想要在静态方法中访问成员变量, 必须要创建对象, 通过对象来访问成员变量.



# 异常处理

#### 1. 纲要

1. 异常的基本概念
2. 异常的分类
3. 异常的捕获和处理
4. 自定义异常
5. 方法的覆盖与异常

#### 2. 异常的基本概念

1. 异常是什么?
   * 第一, 异常模拟的是现实世界中"不正常的"事件;
   * 第二, java中采用"类"去模拟异常;
   * 第三, 类是可以创建对象的.
     * `nullpointerexception e = 0x1234` e是引用类型, e中保存的内存地址指向堆中的"对象". 这个对象一定是nullpointerexception类型. 这个对象就表示真实存在的异常事件. nullpointerexception是一类异常.
     * "抢劫"就是一类异常(这就表示类), "张三被抢劫"就是一个异常事件(这就表示对象).
     * `除数为0时出现arithmeticexception异常的本质` : 编译通过, 但是运行时出现异常, 表示发生了某个异常事件. 程序执行过程中发生了算数异常这个事件, jvm为我们创建了一个arithmeticexception类型的对象. 并且这个对象中包含了详细的异常信息, 并且jvm将这个对象中的信息输出到控制台.
2. 异常机制的作用?
   * java语言为我们提供了一种完善的异常处理机制. 
   * 代码出现了异常, `没有处理`, 下面的代码不会执行, 直接退出jvm.
   * 作用 : 程序发生异常事件之后, 为我们输出详细的信息, 程序员`通过这个信息, 可以对程序进行一些处理, 使程序更加健壮`. (`异常处理机制使程序更加健壮`)

#### 3. 异常的分类

![](D:\Java-figure\19.png)

`注意` : 编译时异常发生几率比较高, 所以需要在编译前处理; 运行时异常发生几率比较低, 所以在编译前不需要处理. 可以与现实世界类比 : 如果出门要带五百万现金, 那么被抢的几率高, 所以出门前要处理, 比如用不透明袋子装着. 出门被天上飞机的轮子砸中可能发生, 但是几率很小, 所以不需要在出门前处理. 

#### 4. 处理异常有两种方式

1. `声明抛出  throws`

   * 声明抛出, 在方法声明的位置上使用throws关键字向上抛出异常.

   * 思考 : java编译器是如何知道一段代码执行过程中可能出现异常, java编译器是如何知道这个异常发生的几率比较高呢?

   * java编译器不是那么智能, 因为fileinputstream这个构造方法在声明的位置上使用了`throws filenotfoundexception`.

   * 深入throws(实例) :

     ![](D:\Java-figure\20.png)

     ![](D:\Java-figure\21.png) 

     * 使用throws处理异常不是真正处理异常而是推卸责任.
     * 谁调用的就会抛给谁.
     * 一直向上抛, 如果没有方法处理(try...catch), 则最后main方法抛给JVM.
     * main方法中m1方法如果出现了异常, 因为采用的是上抛, 给了JVM, JVM遇到这个异常就会退出JVM, main方法中m1后面的代码就不会执行.
     * 一个方法可以throws(上抛)多个异常.
     * 真正处理要使用`try...catch...`

2. `捕捉  try...catch...`

   * 语法 : 

     ```java
     try {
         可能出现异常的代码;
     }catch(异常类型1 变量) {
         处理异常的代码;
     }catch(异常类型2 变量) {
         处理异常的代码;
     }...
     ```

   * catch语句块可以写多个;

   * catch可以写多个, 但是从上到下, 必须从小类型异常到大类型异常进行捕捉;

   * `try...catch...`中最多执行1个catch语句块. 执行结束之后try...catch...就结束了.

   * try中一行代码出现了异常, try语句块中异常代码后面的代码不再继续执行, 直接进入catch语句块中执行.

   * 实例 :

     ![](D:\Java-figure\22.png)

     ![](D:\Java-figure\23.png)

#### 5. getMessage()和printStackTrace()方法

* `e.printStackTrace()` : 打印异常堆栈信息, 信息比较详细. 一般情况下都会使用该方法去调试程序. (常用)
* `e.getMessage()` : 取得异常描述信息, 但信息比较粗略.

#### 6. finally语句

* finally语句块可以直接和try语句块联用. 

* `try...finally...`, `try...catch...finally`两种形式.

* 在finally语句块中的代码是一定会执行的.

* 只有一种情况finally语句不执行 : `只要在执行finally语句块之前退出了JVM, 则finally语句块不会执行`. 

* System.exit(0) : 退出JVM.

  ![](D:\Java-figure\24.png)

* 深入finally语句块(实例) : 

  ![](D:\Java-figure\25.png)

* finally语句块是一定会执行的, 所以通常在程序中为了保证某资源一定会释放, 所以一般在finally语句块中释放资源. 

  ![](D:\Java-figure\26.png)

#### 7. final, finalize和finally?

* 三者没有关系.

#### 8. 如何手动抛出异常

##### 8.1 如何自定义异常

* 自定义异常有两种 :

  1. 编译时异常, 直接继承`Exception`
  2. 运行时异常, 直接继承`RuntimeException`

* 定义异常一般提供两个构造方法 : 

  ![](D:\Java-figure\27.png)

* 实例 : 自定义无效名字异常, 顾客相关业务, 模拟注册.

  ![](D:\Java-figure\29.png)

  ![](D:\Java-figure\28.png)

  ![](D:\Java-figure\30.png)

##### 8.2 如何手动抛出异常

* 使用`throw`关键字. 
* 一般throw和throws联用, 而不和try...catch...联用.

#### 9. 方法的覆盖与异常

* 重写的方法不能比被重写的方法抛出更宽泛的异常.
* 子类永远无法抛出比父类更多的异常.



# IO流

#### 1. 纲要

1. Java流概念
2. 文件流
3. 缓冲流
4. 转换流
5. 打印流
6. 对象流
7. file类
8. zip格式

#### 2. Java流概念

![](D:\Java-figure\31.png)

* 流根据方向可以分为`输入流和输出流`. 
* 注意 : 输入和输出时相对于`内存`而言的. 从内存出来就是输出, 到内存中就是输入. 输入流又叫做`InputStream`, 输出流又叫做`OutputStream`. 输入还叫做`读Read`, 输出还叫做`写Write`.

* 流根据读取数据的方式可以分为: `字节流和字符流`. 字节流是按照字节的方式读取, 字符流是按照字符方式读取, 一次读取2个字节. java语言中`一个字符占2个字节`.
* java中所有的字节流都以`Stream`结尾. 所有的字符流都含有`Reader或Writer`.
* 什么情况下使用字节流/字符流?
  * 字节流适合读取: `视频, 声音, 图片等二进制文件`.
  * 字符流适合读取: `纯文本文件`.

* 需要掌握的16的个流(java.io.*) : 

  * fileinputstream

  * fileoutputstream

  * filereader

  * filewriter

    上面4个专门读取文件.

  * bufferedreader

  * bufferedwriter

  * bufferedinputstream

  * bufferedoutputstream

    上面4个是带有缓冲区的.

  * datainputstream

  * dataoutputstream

    上面2个专门读取数据.

  * objectinputstream

  * objectoutputstream

    上面2个专门读取java对象.

  * inputstreamreader

  * outputstreamwriter

    上面2个是转换流(将字节流转换成字符流).

  * printwriter

  * printstream  //  标准输出流(默认输出到控制台).

    上面2个是打印流.

#### 3. 流的继承结构图

* java语言中的流分为 : 四大家族(inputstream, outputstream, reader, writer).

* inputstream和OutputStream的继承结构图 :

  ![](D:\Java-figure\32.png)

  * flush是刷新. 相当于往用一个小桶往大通中倒水, 当最后一桶倒完后, 把最后小桶中的水根也倒进大通中(倒干净). 也就是把数据完全输出.
  * inputstream和OutputStream都是抽象类.

* reader和writer的继承结构图 : 

  ![](D:\Java-figure\33.png)

#### 4. fileinputstream

##### 4.1 fileinputstream基础

![](D:\Java-figure\34.png)

![](D:\Java-figure\35.png)

![](D:\Java-figure\36.png)

* java.io.fileinputstream是文件字节输入流, 它的直接父类是java.io.inputstream. 按照字节方式读取文件.
* `注意` : `\在java中具有转义功能`, 为了表示路径, 所以要用`\\`. 但是在windows中`\`和`/`都可以用在路径中, 而`/`在java中不具有转义功能, 所以可以直接使用`/`.
* `注意` : 使用throws抛出异常时, 是方法抛出, 不是类. 
* 读取文件的步骤 : 
  * 要读取某文件, 先与这个文件创建一个"输入流";
  * 开始读, 使用`read()方法`(fileinputstream类的方法), 以字节的方式读取. 例如 : a的ASCII值是97, 一个字节可以存放, 可以一次读取出来, 输出是97. 但是一个汉字占两个字节, 所以一次只能读一半.
  * 关闭文件. 为了保证流一定会释放, 所以在finally语句块中执行`关闭文件操作`.
* 注意 : 如果已经读取到文件的末尾, 就会返回`-1`.
* `流是一个东西和内存之间的连接.` 文件保存在硬盘中.

* 实例 : 在循环中使用read, read只能一次读取一个字节, 不能一次读取多个, 所以存在缺点 : 频繁访问磁盘, 伤害磁盘, 并且效率低. 

  ![](D:\Java-figure\37.png)

##### 4.2 fileinputstream读取到内存的byte数组

* `int read(byte[] bytes)` : 读取之前在内存中准备一个byte数组, 每次读取多个字节存储到byte数组中. 一次读取多个字节, 不是单字节读取了. 效率高. `该方法返回的int类型的值代表的是这次读取了多少字节`. 这个byte数组相当于一个临时缓存区.

* 读取流程 : 

  1. 创建输入流;
  2. 开始读, `准备一个byte数组`();
  3. 关闭.

  ![](D:\Java-figure\38.png)

* 将byte数组转换成字符串 : `new String(bytes)`(可以全部转换, 也可以部分转换).

  ![](D:\Java-figure\39.png)

  ![](D:\Java-figure\40.png)

##### 4.3 fileinputstream循环读取

![](D:\Java-figure\41.png)

![](D:\Java-figure\42.png)

* `注意` : 不要使用`println`进行额外换行, 使用`print`就可以了. 文件内部有自己的换行.

##### 4.4 fileinputstream之byte数组转换成字符串

![](D:\Java-figure\43.png)

##### 4.5 fileinputstream之available和skip方法

* `available()方法` : 返回流中剩余的估计字节数.

  ![](D:\Java-figure\44.png)

* `skip(2)` : 跳过两个字节.

  ![](D:\Java-figure\45.png)

#### 5. fileoutputstream

![](D:\Java-figure\46.png)

* `java.io.fileoutputstream` : 文件字节输出流. 它的直接父类是`java.io.outputstream`.
* `将计算机内存中的数据写入硬盘文件中`.

* 写入文件流程 : 
  1. 创建文件字节输出流;
  2. 开始写, `推荐最后的时候为了保证数据完全写入硬盘, 所以要刷新`. 将string转换成byte数组`使用.getBytes()方法`. 使用`write()方法`.
  3. 关闭.

* `fos.flush()` : 强制写入(刷新).

* `注意` : 如果要写入的文件不存在, 则自动创建.

* fileoutputstream的构造方法有两种 : 一种是直接覆盖写入, 另一种是以追加的方式写入.

  ![](D:\Java-figure\47.png)

* 将byte数组的一部分写入 : `fos.write(bytes, 0, 3)`

  ![](D:\Java-figure\48.png)

#### 6. 使用fileinputstream和fileoutputstream完成文件的复制和粘贴

![](D:\Java-figure\49.png)

#### 7. filereader

![](D:\Java-figure\50.png)

* `java.io.filereader` : 文件字符输入流. 它的直接父类是`java.jo.inputstreamreader`(转换流 : 字节输入流 ---> 字符输入流). 它的直接父类的父类是`java.io.reader`.
* filereader的流程和fileinputstream的流程一样. 不同的是 : filereader使用字符数组, fileinputstream使用字节数组.

#### 8. filewriter

![](D:\Java-figure\51.png)

* `java.io.filewriter` : 文件字符输出流. 它的直接父类是`java.io.outputstreamwriter`(转换流 : 字节输出流 ---> 字符输出流). 它的直接父类的父类是`java.io.writer`.

* filewriter的流程和fileoutputstream的流程一样. 不同的是 : filewriter可以直接将字符串写入而不用数组, fileoutputstream使用字节数组. 

#### 9. 使用filereader和filewriter完成文件的复制和粘贴

![](D:\Java-figure\52.png)

* `只能复制纯文本`.

#### 10. bufferedreader

![](D:\Java-figure\53.png)

* bufferedreader和bufferedwriter分别是`带有缓冲区的字符输入流`和`带有缓冲区的字符输出流`.

* bufferedreader是自己带有缓存, 前面几个使用的type数组相当于一个缓存.

* 使用bufferedreader的流程 : 

  1. 创建一个带有缓冲区的字符输入流
     * bufferedreader类的构造方法的参数是一个`reader对象`, 但是reader是一个抽象类, 所以可以使用它的具体子类. 
     * `bufferedreader br = new bufferedreader(new filereader("..."))` : 将文件字符输入流包装成带有缓冲区的字符输入流.
     * `根据流出现的位置`, 流又可以分为 : `包装流 / 处理流` 和 `节点流`. 例如 : filereader fr 是一个节点流; bufferedreader br 是一个包装流/处理流.
     * 包装流和节点流是相对而言的. 创建包装类对象时传入了一个对象参数, 该对象参数就是一个节点流, 而包装类对象就是一个包装流.

  2. 开始读
     * bufferedreader类中有一个`redaline()方法`, 该方法用来`读取一个文本行`. 如果已经到达流末尾, 则返回`null`.
     * 注意 : readline()方法读取一行, 但是`行尾不带换行符`.

  3. 关闭
     * 关闭时注意 : `关闭时只需要关闭最外层的包装流`(这里有一个装饰者模式).
     * `注意` : 设计模式包括三种, 第一种是单例模式, 第二种是装饰者模式.

* bufferedreader类的构造方法的参数是一个`reader对象`, 但是reader是一个抽象类, 所以可以使用它的具体子类. 注意不仅可以是字符流, 还可以是字节流, 只是需要通过转换流将该字节流进行包装, 然后再传给bufferedreader.

  ![](D:\Java-figure\54.png)

#### 11. bufferedreader通过用户键盘输入

*  以前的方式使用`scanner`类 : `scanner s = new scanner(system.in)`

  ![](D:\Java-figure\56.png)

  ![](D:\Java-figure\55.png)

  * system.in是一个`标准的输入流`, `默认接受键盘的输入`.
  * 使用next方法接收时以空格为界限.

* 使用bufferedreader用来接受用户的输入 : 

  ![](D:\Java-figure\57.png)

#### 12. bufferedwriter

![](D:\Java-figure\58.png)

* 可以通过`newline()`方法`写入一个行分隔符`.

 #### 13. 使用bufferedreader和bufferedwriter完成复制和粘贴

![](D:\Java-figure\59.png)

#### 14. Decorator装饰者模式

* 对软件进行升级，也就是在原代码的基础上进行扩展而不修改原代码
  * 方法一 ：继承，重写方法。（不推荐，代码耦合度太高，不利于项目的扩展。）
  * 方法二 ：使用装饰者模式。

* 实例 ：使用bufferedreader对filereader中的close方法进行扩展。

  `被装饰者` : 

  ![](D:\Java-figure\61.png)

  `被装饰者` : 

  ![](D:\Java-figure\60.png)

  `测试` : 第一步是创建被装饰者; 第二步是创建装饰者; 第三步是通过执行装饰者中的方法间接去执行被装饰者中的方法.

  ![](D:\Java-figure\62.png)

  * bufferedreader是装饰者，filereader是被装饰者。
  * bufferedreader和filereader是关联关系。
  * 之所以只关闭装饰者(close方法)就可以了, 是因为装饰者中的对被装饰者的引用也就通过调用close方法关闭了.

* 装饰者模式中要求 : `装饰者中含有被装饰者的引用`.

* 装饰者模式中要求 : `装饰者和被装饰者应该实现同一个接口/类型`. (例如 : 都继承一个抽象类.)

* 通过让bufferedreader和filereader继承抽象类reader使得它们两个的关系就彻底不大了(其中下面第三, 四张图片一起使用了多态).

  ![](D:\Java-figure\65.png)

  ![](D:\Java-figure\64.png)

  ![](D:\Java-figure\63.png)

  ![](D:\Java-figure\66.png)

#### 15. datainputstream和dataoutputstream

![](D:\Java-figure\67.png)

* 这两个是专项的, 可以带着类型读取和写入. 而其他的只能值字符串或字节.

##### 15.1 dataoutputstream

* dataoutputstream可以将内存中的 "int i = 10;" 写入到硬盘文件中, 写进去的`不是字符串`, 写进去的是`二进制数据`, `带类型`.

* dataoutputstream的构造函数的参数是一个outputstream类的对象. 但是参数也可以是outputstream的子类对象(多态 : 父类对象引用指向子类对象).

  ![](D:\Java-figure\68.png)

* dataoutputstream的使用流程 : 

  ![](D:\Java-figure\69.png)

  ![](D:\Java-figure\70.png)

  * 创建数据字节输出流
  * 准备数据
  * 开始写
  * 刷新
  * 关闭

##### 15.2 datainputstream

* `注意` : 使用datainputstream读取二进制文件时, 要提前知道文件中`数据的格式, 顺序`. `读的顺序必须和写入的顺序相同`. 使用dataoutputstream往一个文件中写入数据, 该文件就是二进制文件.

  ![](D:\Java-figure\71.png)

#### 16. printstream和printwriter

* `java.io.printwriter` : 以字符方式.

* `java.io.printstream` : 标准的输出流, 默认打印到控制台. `以字节方式`.

  * `PrintStream ps = System.out`(默认输出到控制台)

    ![](D:\Java-figure\72.png)

    ![](D:\Java-figure\74.png)

  *  可以改变输出方向, system中有一个方法 : `setOut(printstream out)`(重新分配标准输出流). 对于printstream类, 它有一个构造方法, 参数是outputstream类的对象. `通常使用这种方式记录日志`.

    ![](D:\Java-figure\73.png)

* 需求 : 记录日志, m1方法开始执行的时间和结束的时间. 记录到log文件中.

  ![](D:\Java-figure\75.png)

  ![](D:\Java-figure\76.png)

#### 17. objectoutputstream和objectinputstream对象的序列化和反序列化

* `java.io.objectoutputstream` : 序列化`JAVA对象`到硬盘. (serial)

* `java.io.objectinputstream` : 将硬盘中的数据"反序列化"到JVM内存. (deserial)

* compile是编译(java-->class); decompile是反编译(class-->java).

* objectoutputstream和objectinputstream是专项流.

* 什么是序列化, 反序列化?

  ![](D:\Java-figure\77.png)

  ![](D:\Java-figure\82.png)

* objectoutputstream的使用流程 : 

  ![](D:\Java-figure\81.png)

  ![](D:\Java-figure\80.png)

  1. 创建java对象;

  2. 创建输出流(序列化流) (jvm中的java对象状态保存到硬盘中). objectoutputstream类的一个构造方法的参数是outputstream对象.

     ![](D:\Java-figure\78.png)

  3. 写. objectoutputstream类中有一个方法 : `writeobject`. 

     ![](D:\Java-figure\79.png)

  4. 刷新

  5. 关闭

* `注意` : 使用objectoutputstream序列化的对象如果没有实现`Serializable`接口, 则不能对该对象进行序列化. 该接口是一个`可序列化的`. `该接口没有任何方法`, 是一个`标识接口`. 像这样的接口还有 : `java.io.Cloneable`(可克隆的).

* `标识接口的作用` : JVM如果看到该对象实现了某个标识接口, 会对它特殊待遇.

* 疑问 : User实现serializable接口, JVM对它的特殊待遇是什么?

* objectinputstream的使用流程 : 

  ![](D:\Java-figure\83.png)

  1. 创建反序列化流;
  2. 反序列化;
  3. 关闭.

#### 18. 序列化版本号SerialVersionUID

![](D:\Java-figure\84.png)

![](D:\Java-figure\88.png)

![](D:\Java-figure\86.png)

* 出现的错误 : 

  ![](D:\Java-figure\85.png)

* 出现错误的原因以及解决办法 : 

  ![](D:\Java-figure\87.png)

  * 因为User实现了Serializable接口, JVM会特殊待遇 : `会给该类添加一个属性, static final long serialVersionUID = ...` 
  * 可以不让系统自动生成, 自己写一个序列化版本号.

* 如果不想让该属性参加序列化, 需要使用`transient关键字`修饰.

#### 19. file类

* `java.io.File` : 

  1. File类和流无关, 不能通过该类完成文件的读和写;
  2. File是文件和目录路径名的抽象表示形式;
  3. File代表的是硬盘上的directory和file.

* File类的构造方法 : 

  ![](D:\Java-figure\89.png)

  * `File f1 = new File("path")` : path可以是相对路径也可以是绝对路径

* File类的一个方法 : `exists()`(测试此抽象路径名表示的文件或目录是否存在.)

  ![](D:\Java-figure\91.png)

* 如果不存在则以`目录或文件`的形式创建 : 

  * 使用File类的一个创建目录的方法 : `mkdir()`

  * 使用File类的一个创建文件的方法 : `creatNewFile()`

    ![](D:\Java-figure\90.png)

  * 创建多重目录 : `mkdirs()`

    ![](D:\Java-figure\92.png)

* File类的其他方法 : 

  ![](D:\Java-figure\93.png)

  ![](D:\Java-figure\95.png)

  ![](D:\Java-figure\98.png)

  ![](D:\Java-figure\102.png)

  1. `getAbsolutePath()` : 获取绝对路径

     ![](D:\Java-figure\94.png)

  2. `getName()` : 获取文件名

     ![](D:\Java-figure\96.png)

  3. `getParent()` : 获取父路径

     ![](D:\Java-figure\97.png)

  4. `isDirectory() / isFile()` : 判断该File是directory还是file

     ![](D:\Java-figure\99.png)

  5. `lastModified()` : 获取文件最后一次修改的时间, 返回值为long类型, 可以转为Date类型.

     ![](D:\Java-figure\100.png)

  6. `length()` : 获取文件的长度(`字节数`)

     ![](D:\Java-figure\101.png)

  7. `listFiles()` : 列出子文件, 返回的是File数组, 可以使用`增强for循环`遍历输出.

     ![](D:\Java-figure\103.png)

* 使用递归找出某目录下的所有子目录以及子文件

  ![](D:\Java-figure\104.png)

  ![](D:\Java-figure\105.png)



# 集合

#### 1. 纲要

* 主要集合概念
* Collection和Iterator
* List
* Set
* Map
* Collections工具类
* Comparable与Comparator

#### 2. 主要集合概念

* 集合实际上就是一个容器, 用来存储其他类型. 
* 集合分为两种 : 一个一个存(Colllection); 一对一对存(Map).
* `注意` : java中, 集合只能用来存储引用类型.
* java集合主要有3种重要的类型 : 
  * `List` : 有序集合, 可以存放重复的数据;
  * `Set` : 无序集合, 不允许存放重复的数据;
  * `Map` : 无序集合, 集合中包含一个键对象, 一个值对象, 键对象不允许重复, 值对象可以重复.
* 集合底层是数据结构, 例如 : 数组, 二叉树, 哈希表等等.

#### 3. 集合的继承结构图

##### 3.1 Collection的继承结构图

![](D:\Java-figure\106.png)

* `Iterable`接口 : 表示可迭代的, Collection接口的父接口就是Iterable, 所有的集合都是可迭代的, 迭代就是遍历. 该接口中有一个iterator()方法(迭代器). 所有集合都有该方法, 集合通过该方法得到迭代器, 集合获取到迭代器之后, 可以使用迭代器去遍历集合(通过迭代器中的三个方法实现遍历). 

* 上层是接口(抽象), 下层是真正的实现接口的类. 编程时面向接口编程.

* 实现接口的类的底层都有相应的数据结构.
  * arraylist类底层采用的是数组存储元素的, 所以arraylist集合适合查询, 不适合频繁的随机增删元素;
  * linkedlist类底层采用双向链表这种数据结构存储数据的, 链表适合频繁的增删元素, 不适合查询操作;
  * vector类底层和arraylist结合相同, 但是vector是线程安全的, 效率较低, 所以现在很少使用.

##### 3.2 Map的继承结构图

![](D:\Java-figure\107.png)

* Map集合的键的特点 : 无序不可重复. Map和Collection没有关系.
* HashMap是Map接口的实现类, 该类中的key等同于一个set集合.
* Hashtable类是map接口的实现类, 该类下有一个子类是`Properties`(属性类), 该子类的key和value只能是`字符串`.
* SortedMap接口是Map的子接口, 该接口中的key等同于SortedSet.
* TreeMap类是sortedmap接口的实现类, treemap的key就是一个treeset.

#### 4. 数据结构之单向链表和双向列表

##### 4.1 单向链表

![](D:\Java-figure\108.png)

* 使用java语言模拟单向链表

  ![](D:\Java-figure\109.png)   

##### 4.2 双向链表

![](D:\Java-figure\110.png)

#### 5. Collection集合的常用方法

![](D:\Java-figure\111.png)

* 创建集合 : 由于collection是接口, 不能直接new接口, 所以要new一个该接口的实现类(例如 : new arraylist()) (这是`多态`).

  ![](D:\Java-figure\112.png)

* `add(object o)` : 添加元素. collection集合只能单个存储元素, 并且只能存储引用类型.

  ![](D:\Java-figure\113.png)

* `size()` : 获取集合中元素的个数.

* `clear()` : 清空集合.

* `isEmpty()` : 判断集合中是否有元素.

* `toArray()` : 将集合转换成object类型的数组.

  ![](D:\Java-figure\114.png)

  * 使用`system.out.println()`输出一个类的对象时自动调用该类`toString()`方法. 所以当重写该类的这个方法后, 输出该类的对象时输出的内容就是重写后的内容.

* `Iterator iterator()` : 获取集合所依赖的迭代器对象. 通过迭代器中方法完成集合的迭代(遍历). 注意 : `这种方式是所有集合通用的遍历方式`.

  ![](D:\Java-figure\120.png)

  `注意` : 编写过程中没有用到任何一个类, 用的都是接口, 但是底层用到了真实存在的对象.

  1. 获取迭代器对象 : `Iterator it = c.iterator()` (迭代器是面向接口编程, Iterator是接口. it是引用, 保存了内存地址, 指向堆中的"迭代器对象".)

     `注意` : 不需要关心底层集合的具体类型, 所有集合依赖的迭代器都实现了`java.util.Iterator`接口.

     ![](D:\Java-figure\115.png)

  2. 开始调用方法,  完成遍历, 迭代.

     ![](D:\Java-figure\116.png)

     ![](D:\Java-figure\117.png)

     ![](D:\Java-figure\118.png)

     ![](D:\Java-figure\119.png)

     * `boolean b = it.hasNext()` : 判断是否有更多的元素, 如果有返回true.
     * `object 0 = it.next()` : 将迭代器向下移动一位, 并且取出指向的元素.
     * 原则 : `调用it.next()方法之前必须调用it.hasNext()`.

* `contains(object o)` : 判断集合中是否包含某个元素.

  ![](D:\Java-figure\121.png)

  * contains方法底层调用的是equals方法. 如果equals返回true, 就是包含. 所以将没有加入集合的i2作为contains的参数后, 底层会将i2与集合中的i1通过equals方法进行判断. 由于integer本身重写了equals方法, 所以将i2作为参数传给contains方法时, 返回值为true.

    ![](D:\Java-figure\122.png)

    ![](D:\Java-figure\123.png)

  * 如果是对象, 则调用对象中的equals方法, 由于m1和m2的引用保存的对象的地址不同, 所以使用contains方法的返回值为false.

    ![](D:\Java-figure\124.png)

  * 对于一般来说, 想要比较的不是引用, 而是保存的对象的内容, 所以需要重写当前类中的equals方法.

    ![](D:\Java-figure\125.png)

  * `注意` : `存储在集合中的元素应该去重写equals方法`.

* `remove(object o)` : 删除集合中某个元素.   

  ![](D:\Java-figure\126.png)

  * `注意` : `remove和contains方法都需要集合中的元素重写equals方法`. 因为object中的equals方法比较内存地址, 在现实的业务逻辑当中不能比较内存地址, 该比较内容.

  * 深入remove方法 : 

    ![](D:\Java-figure\127.png)

    1. 迭代器的remove方法;
    2. 集合自身带的remove方法.

    `注意` : 推荐使用迭代器自身带的remove方法删除元素.

#### 6. List集合

* list集合存储元素特点 : 

  1. 有序(list集合中存储有下标) : 存进去是这样的顺序, 取出来还是按照这个顺序取出;
  2. 可重复.

  ![](D:\Java-figure\128.png)

* 深入list集合 : 

  * arraylist集合底层是数组. 数组是有下标的. 所以arraylist集合有很多自己的特性.
  * arraylist集合底层默认初始化容量是10. 扩大之后的容量是原容量的1.5倍.
  * vector集合底层默认初始化容量也是10. 扩大之后的容量是原容量的2倍.
  * 如何优化arraylist和vector?
    * 尽量减少扩容操作, 因为扩容需要数组拷贝. 数组拷贝很耗内存.
    * 一般推荐在创建集合的时候指定初始化容量.
  * list除了有collection的方法外, 它还有自己的特殊方法, 例如 : `add(索引, 要添加的值); get(索引)`. 因为list有get方法, 所以list集合有特有的遍历方式, 使用for循环, 当然也可以使用迭代器.

  ![](D:\Java-figure\129.png)

  * 面向抽象编程 : 只修改具体类即可(底层数据结构的改动), 不需要改后面的代码. 因为linkedlist和arraylist都实现了list接口, 后面使用到的方法它们都有.

    ![](D:\Java-figure\130.png)

#### 7. 数据结构之哈希表和散列表

![](D:\Java-figure\131.png)

* hashset底层实际上是一个hashmap. 而hashmap底层的数据结构是哈希表或散列表. hashset有无序不可重复的特点, 所以hashset相当于hashmap的key部分.
* hashmap中有两个方法 :
  1. `object get(object key)` : 得到key对应的value.
  2. `void put(object key, object value)` : 添加一个元素有两种形式, 通过key调用hashcode方法得到的值, 再通过"哈希算法"得出的哈希值, 如果这个哈希值在数组中有, 则往对应的单链表中查询, 与当前单链表中的元素一一通过equals方法进行对比, 如果都返回false, 则加入到当前链表, 如果存在一个true, 则放弃添加当前元素; 如果这个哈希值在数组中没有, 则在数组末尾新加入该元素.

#### 8. HashSet集合

![](D:\Java-figure\132.png)

* hashset底层实际上是一个hashmap, hashmap底层采用了哈希表数据结构.

* 哈希表又叫做散列表, 哈希表底层是一个数组, 这个数组中每一个元素是一个单项链表. 每个单向链表都有一个独一无二hash值, 代表数组的下标. 在某个单向链表中的每一个节点上的hash值是相等的. hash值实际上是key调用hashcode方法, 在通过"hash function"转换成的值.

* 如何向哈希表中添加元素 : 先调用被存储的key的hashcode方法, 经过某个算法得出hash值, 如果在这个哈希表中不存在这个hash值, 则直接加入元素. 如果该hash值已经存在, 继续调用key之间的equals方法, 如果equals方法返回false, 则将该元素添加. 如果equals方法返回true, 则放弃添加该元素.

* hashset其实是hashmap中的key部分. hashset的特点和hashmap中的key应该具有相同的特点.

* hashmap和hashset初始化容量都是16, 默认加载因子是0.75.

* 关于往set集合中存储的元素, 该元素hashcode和equals方法.

  ![](D:\Java-figure\133.png)

  ![](D:\Java-figure\134.png)

  * hashmap中有一个put方法, put(key, value)中的key是无序不可重复的.
  * 注意 : `hashcode和equals方法是类的, 准确的说是Object类的, 因为所有类都是object的子类, 所以所有类都有这些方法`.
  * 如果直接使用类提供了hashcode, 由于在hashset中存储的是引用, 所以即使两个对象的内容的是相同的, 但由于它们是各自new出来的, 各自的引用中存的地址不同, 所以hash值(数组下标)都是不同的. 因此都是存储在数组中, 没有单链表. 如果想要实现按对象内容来进行添加操作, 那么就需要重写该类的hashcode和equals方法.
  * `注意` : `Object类所提供的方法一般都是要重写的`. 
  * `结论` : 存储在hashset集合或者hashmap集合key部分的元素, 需要同时重写hashcode和equals方法. 
  * 重写hashcode的目的 : 在散列表中使得`散列均匀分布`.

#### 9. SortedSet集合

![](D:\Java-figure\135.png)

![](D:\Java-figure\136.png)

![](D:\Java-figure\137.png)

* `java.util.sortedset` : 无序不可重复, 但是存进去的元素可以按照元素大小顺序自动排列. sortedset接口的父接口是`java.util.set`, sortedset接口的实现类是`java.util.treeset`.

* 可以对整型, 字符串, 日期进行排序. 它们都实现了`Comparable`这个接口, 这个接口有一个方法 : `compareTo`(比较此对象与指定对象的顺序).

* sortedset集合存储元素为什么可以自动排序?

  * 因为被存储的元素(对象)实现了comparable接口, sun编写treeset集合在添加元素的时候, 会调用compareto方法完成比较.

  ![](D:\Java-figure\138.png)

  ![](D:\Java-figure\139.png)

  * 当要将自定义的类的对象添加到sortedset中进行自定排序时, 该自定义的类要实现`Comparable`接口中的`compareTo方法`. 该方法程序员负责实现, SUN提供的程序已经调用了该方法. 这就是接口的其中一个作用 : 使项目分层(面向接口实现(程序员), 面向接口调用(SUN的程序员)).
  * java中已经写好的类已经实现了`Comparable`接口, 例如 : 整型类, 字符串, 日期等等. 所以可以直接将这三个类型的对象添加到sortedset进行自动排序.
  
* (推荐)让sortedset集合做到排序还有另一种方式 : `java.util.comparator`. 单独编写一个比较器. 即`创建treeset集合的时候提供一个比较器`.

  ![](D:\Java-figure\140.png)

  ![](D:\Java-figure\141.png)

  ![](D:\Java-figure\144.png)

  ![](D:\Java-figure\145.png)

  * treeset类中有一个构造方法 :

    ![](D:\Java-figure\146.png)

  * comparator接口中有两个方法 : `compare(T o1, T o2)`; `equals(object obj)`.

    ![](D:\Java-figure\142.png)

    ![](D:\Java-figure\143.png)

  * `((Product)o1).price` : 强制类型转换, 只有转换之后才能调用price.

* treeset的构造方法 :

  ![](D:\Java-figure\147.png)

* comparable和comparator的区别？
  * 一个类实现了comparable接口则表明这个类的对象之间是可以互相比较的，这个类对象组成的集合就可以直接使用sort方法排序。
  * comparator可以看成一种算法的实现，将算法和数据分离，comparator也可以在下面两种环境下使用：
    1. 类没有考虑到比较问题而没有实现comparable，可以通过comparator来实现排序而不必改变对象本身。
    2. 可以使用多种排序标准，比如升序，降序等。

#### 10. Map集合

* hashset底层是hashmap, 相当于hashmap中的key. hashmap中的key要重写hashcode+equals方法. sortedset相当于sortedmap中的key. treemap的key就是一个treeset. sortedmap或treemap中的key需要实现comparable接口或单独写个比较器.

* 关于map集合中常用的方法 :

  ![](D:\Java-figure\148.png)

  ![](D:\Java-figure\149.png)

  `注意` : 存储在map集合key部分的元素需要同时重写hashcode+equals方法.

  1. 创建map集合 : hashmap的默认初始化容量是16, 默认加载因子是0.75.

     ![](D:\Java-figure\150.png)

  2. 存储键值对 : `put(object key, object value)`

     ![](D:\Java-figure\151.png)

  3. 判断键值对的个数 : `size()` (map中的key是无序不可重复的, 和hashset相同)

     ![](D:\Java-figure\152.png)

  4. 判断集合中是否包含这样的key : `containsKey(object key)`

     ![](D:\Java-figure\153.png)

  5. 判断集合中是否包含这样的value : `containsValue(object value)` (注意 : `map中如果key重复了, value采用的是"覆盖"`.)

     ![](D:\Java-figure\154.png)

  6. 通过key获取value : `get(object key)`

     ![](D:\Java-figure\155.png)

  7. 通过key删除键值对 : `remove(object key)`

     ![](D:\Java-figure\156.png)

  8. 获取所有的value : `values()`

     ![](D:\Java-figure\157.png)

  9. 获取所有的key : `keySet()` (`以下程序演示如何遍历map集合`)

     ![](D:\Java-figure\158.png)

  10. `将map集合转换成set集合` : `entryset`

      ![](D:\Java-figure\159.png)

#### 11. Hashtable的子类Properties类

![](D:\Java-figure\160.png)

* hashmap默认初始化容量是16, 默认加载因子是0.75; hashtable默认初始化容量是11, 默认加载因子是0.75.
* `java.util.Properties` : 也是由key和value组成, 但是key和value都是`字符串类型`.
* Properties类的两个方法 :
  * `setProperties` : 存
  * `getProperyies` : 取, 通过key获取value.
* 注意 : `key 不能重复, 如果重复则value覆盖`.

#### 12. TreeMap中的key可以自动排序

![](D:\Java-figure\161.png)

![](D:\Java-figure\162.png)

![](D:\Java-figure\163.png)

* sortedmap中的key特点 : 无序不可重复, 但是存进去的元素可以按照大小自动排序. 如果想要自动排序, key部分的元素需要 : `实现comparable接口` 或者 `单独写一个比较器`.

#### 13. Collections工具类

![](D:\Java-figure\164.png)

* `java.util.Collections` : 集合工具类, 它是个类. `java.util.Collection`是集合接口.

* 可以使用collections工具完成集合的排序 :

  ![](D:\Java-figure\165.png)

* collections类中确实有一个sort方法, 但是它的参数只能是list类型 : 

  ![](D:\Java-figure\166.png)

* 如果想让set集合也能使用sort方法, 需要将set集合转换成list集合. list构造方法就可以实现这个转换.

  ![](D:\Java-figure\167.png)

  ![](D:\Java-figure\168.png)

* 创建list集合, list集合中存储Person类型, 是否可以排序?

  * collections工具类可以对list集合中的元素排序, 但是集合中的元素必须是"可比较的", 实现comparable接口.

  ![](D:\Java-figure\169.png)

* 将arraylist集合转换成线程安全的 : 

  ![](D:\Java-figure\170.png)

#### 14. 泛型初步

* JDK5.0新特性 : 泛型(`编译期概念`)

* 为什么引入泛型?

  1. 可以`统一集合中的数据类型`;
  2. 可以`减少强制类型转换`.

* 泛型如何实现?

  * 泛型是一个编译阶段的语法. 在编译阶段统一集合中的类型.

  ![](D:\Java-figure\173.png)

  * Map使用泛型 : 

    ![](D:\Java-figure\174.png)

  * SortedSet集合使用泛型 : 

    ![](D:\Java-figure\175.png)

    ![](D:\Java-figure\176.png)

* 泛型的优点和缺点?

  * 优点 : 统一类型, 减少强制类型转换;
  * 缺点 : 只能存储一种类型.

* 以下程序没有使用泛型, 缺点?

  * 如果集合不使用泛型, 则集合中的元素类型不统一, 在遍历集合的时候, 只能拿出来object类型, 需要做大量的强制类型转换, 才能调用不同类型的方法, 麻烦.

  ![](D:\Java-figure\171.png)

  ![172](D:\Java-figure\172.png)

* 自定义泛型 : 

  ![](D:\Java-figure\177.png)

#### 15. 增强for循环: foreach

![](D:\Java-figure\178.png)

![](D:\Java-figure\179.png)

* JDK5.0新特性 : 增强for循环(foreach).

* 语法 : `for(类型 变量 : 数组名/集合名){}`

* 注意 : `集合想要使用增强for循环这种语法, 集合需要使用泛型`.

* 注意 : `如果集合不使用泛型, 该集合在用增强for循环的时候应该使用object类型定义(需要使用object类型来定义集合中的元素)`.

* 关于增强for循环的缺点 : `没有下标`.

  ![](D:\Java-figure\180.png)

#### 16. Properties类

* **[作用]()** :
  * `java.util.Properties`类主要用于读取java的配置文件, 各种语言都有自己所支持的配置文件, 在java中其配置文件常为`.properties`文件, 格式为文本文件, 文件的内容格式是**键=值**的格式, 文本注释信息可以用#来注释.
  * 配置文件的作用: 配置文件中很多变量是经常改变的, 这样做是为了方便用户, 让用户能够脱离程序本身去修改相关的变量设置.
* **[常用方法]()** :
  1. `getProperty(String key)` : 用指定的键在此属性列表中搜索属性.
  2. `load(InputStream/Reader inStream/in)` : 从输入流中读取属性列表(键值对). 通过对指定的文件进行装载来获取该文件中的所有键值对. 以供getProperty来搜索.
  3. `setProperty(String key, String value)` : 调用hashtable的方法put来设置键值对.
  4. `store(OutputStream out, String comments)` : 以适合使用load方法加载到Properties表中的格式, 将此Properties表中的属性列表(键值对)写入输入流. 与load方法相反, 该方法将键值对写入到指定的文件中.
  5. `clear()` : 清除所有装载的键值对. 该方法在基类中提供.
* **[java读取Properties文件]()** :
  * java读取Properties文件的方法有很多, 但是最常用的还是通过`java.lang.Class`类的`getResourceAsStream(String name)`方法来实现.



# 常用类

#### 1. 纲要

1. String
2. StringBuffer
3. 基础类型对应的8个包装类
4. 日期相关类
5. 数字相关类
6. Random
7. Enum

#### 2. String类

* `java.lang.string` : 是字符串类型.

  ![](D:\Java-figure\182.png)

  ![](D:\Java-figure\183.png)

  * `字符串一旦创建不可再改变`. 例如 : "abc"字符串对象一旦创建, 不可再改变成"abcd".

  * 提升字符串的访问效率 : 在程序中使用了"`缓存`"技术. 所以在java中所有使用"双引号"括起来的字符串都会在"`字符串常量池`"中创建一份. 字符串常量池在方法区中被存储.

    ![](D:\Java-figure\181.png)

  * 在程序执行过程中, 如果程序用到某个字符串, 例如 : `abc`, 那么程序会在字符串常量池中去搜索该字符串, 如果没有找到则在字符串常量池中新建一个"abc"字符串, 如果找到就直接拿过来用. (字符串常量池是一个缓存区, 为了提高访问字符串的效率.)

  * `注意` : `比较两个字符串是否相等, 不能使用"==", 必须使用string类提供的equals方法`. 

  * 在java中`new`时, 是在堆区中分配空间. 

* 分析一下程序创建字符串对象的区别 :

  ![](D:\Java-figure\184.png)

  * `string s1 = "abc"` : 只会在字符串常量池中创建一个"abc"字符串对象.
  * `string s2 = new string("hello")` : 会在字符串常量池中创建一个"hello"字符串对象, 并且会在堆中再创建一个字符串对象.
  * `上面两种方式中第二种方式比较浪费, 常用的是第一种方式.`

* 面试题 : 

  ![](D:\Java-figure\185.png)

* 使用string的时候我们应该注意的问题 : 尽量不要做字符串频繁的拼接操作. 因为字符串一旦创建不可改变, 只要频繁拼接, 就会在字符串常量池中创建大量的字符串对象, 给垃圾回收带来问题.

  ![](D:\Java-figure\186.png)

* 关于字符串常用的6种构造方法 : 

  ![](D:\Java-figure\187.png)

  1. 字符串字面值直接赋值;
  2. 参数为字符串的构造方法;
  3. 参数为byte数组的构造方法;
  4. 参数为byte数组, 并且可以指定范围的构造方法;
  5. 参数为字符数组的构造方法;
  6. 参数为字符数组, 并且可以指定范围的构造方法.

  `注意` : string类已经重写了equals和toString方法.

* 字符串常用的方法 : 

  1. `char charAt(int index)` : 返回指定索引处的char值.

     ![](D:\Java-figure\188.png)

  2. `boolean endsWith(String endstr)` : 测试此字符串是否以指定的后缀结束.

     ![](D:\Java-figure\189.png)

  3. `boolean equalsIgnoreCase(string anotherString)` : 将此string与另一个string比较, 不考虑大小写.

     ![](D:\Java-figure\190.png)

  4. `byte[] getBytes()` : 将字符串转换成byte数组.

     ![](D:\Java-figure\191.png)

  5. `int indexOf(string str)` : 返回指定子字符串在此字符串中第一次出现的索引.

     ![](D:\Java-figure\192.png)

  6. `int indexOf(string str, int fromIndex)` : 返回指定子字符串在此字符串中第一次出现的索引, 从指定的索引开始.

     ![](D:\Java-figure\193.png)

  7. `int lastIndexOf(string str)` : 返回指定字符串在此字符串中最右边出现处的索引.

     ![](D:\Java-figure\194.png)

  8. `int lastIndexOf(string str, int fromIndex)` : 返回指定字符串在此字符串中最后一次出现的索引, 从指定的索引开始反向搜索.

     ![](D:\Java-figure\195.png)

  `注意` : `索引指的是下标.`

  9. `int length()` : 返回此字符串的长度. `数组是length属性, string是length()方法.`

     ![](D:\Java-figure\196.png)

  10. `string replaceAll(string regex, string replacement)` : 使用给定的replacement替换此字符串所有匹配给定的正则表达式的字符串. (`regex即可以是普通字符串/字符, 也可以是正则表达式.`)

      ![](D:\Java-figure\197.png)

  11. `sting[] split(string regex)` : 根据给定正则表达式的匹配拆分此字符串.

      ![](D:\Java-figure\198.png)

  12. `boolean startsWith(string str)` : 测试此字符串是否以指定的前缀开始.
  
      ![](D:\Java-figure\199.png)
  
  13. `string subString(int beginIndex)` : 截取字符串.
  
      ![](D:\Java-figure\200.png)
  
  14. `string subString(int beginIndex, int endIndex)` : 返回一个新的字符串, 它是此字符串的一个字符串. (`截取字符串`) 
  
      ![](D:\Java-figure\201.png)
  
  15. `char[] toCharArray()` : 将此字符串转换为一个新的字符数组. (`将字符串转换为char数组`)
  
      ![](D:\Java-figure\202.png)
  
  16. `string toUpperCase()` : 将此字符串中所有的字符都转换为大写.
  
      ![](D:\Java-figure\204.png)
  
  17. `string toLowerCase()` : 将此字符串中所有的字符都转换为小写.
  
      ![](D:\Java-figure\205.png)
  
  18. `string trim()` : 去掉此字符串的前后空格.
  
      ![](D:\Java-figure\206.png)
  
  19. `static string valueOf(object obj)` : 返回object参数的字符串表示形式.
  
      * 注意 : 当声明一个空引用时, 如果直接输出该引用, 则不会出现空指针异常, 因为输出时并不是直接调用tostring方法, 而是调用valueOf方法, valueOf方法再去调用tostring方法, string.valueOf(object)这个方法对空值进行处理了; 如果输出时显示调用tostring方法, 则会出现空指针异常.
  
      ![](D:\Java-figure\207.png)
  
      ![](D:\Java-figure\203.png)
  
  20. `boolean matches(string regex)` : 告知此字符串是否匹配给定的正则表达式.
  
      ![](D:\Java-figure\209.png)
  
* 正则表达式初步 : 

  ![](D:\Java-figure\208.png)

  1. 正则表达式是一门独立的学科;
  2. 正则表达式是一种字符模型. 专门做字符串格式匹配的;
  3. 正则表达式是通用的. 

  `注意` : java语言中, 单个`\`具有特殊意义, `\\`才能表示正常的反斜杠.

#### 3. StringBuffer和StringBuilder类

* `java.lang.stringbuffer` 和 `java.lang.stringbuilder` 

  ![](D:\Java-figure\211.png)

  * stringbuffer和stringbuilder是什么 : `是一个字符串缓冲区`.
  * 工作原理 : 预先在内存中申请一块空间, 以容纳字符序列, 如果预留的空间不够用, 则进行自动扩容, 以容纳更多字符序列.
  * stringbuffer,stringbuilder 和 string最大的区别 : 
    1. string是不可变的字符序列, 底层是一个字符数组, 类型是final, 所以是不可变的, 存储在字符串常量池中;
    2. stringbuffer底层是一个char数组, 但是该数组是可变的(即不是final类型的), 并且可以自动扩容.
  * stringbuffer和stringbuilder的默认初始化容量是16.
  * 如何优化stringbuffer和stringbuilder : 最好在创建stringbuffer之前, 预测stringbuffer的存储字符数量, 然后再创建stringbuffer的时候采用指定初始化容量的方式创建stringbuffer. 为了减少底层数组的拷贝, 提高效率.
  * `注意` : `推荐字符串频繁拼接使用stringbuffer或者stringbuilder`. stringbuffer和stringbuilder类中都有一个append方法, 用于向缓冲区中添加元素.

* stringbuffer和stringbuilder的区别 : 

  * stringbuffer是线程安全的. (可以在多线程的环境下使用不会出现问题.)
  * stringbuilder是非线程安全的. (在多线程环境下使用可能出现问题.)

#### 4. 包装类型

* java中八种基本数据类型对应的包装类型 :

  1. byte 对应 `java.lang.Byte`
  2. short 对应 `java.lang.Short`
  3. int 对应 `java.lang.Integer`
  4. long 对应 `java.lang.Long`
  5. float 对应 `java.lang.Float`
  6. double 对应 `java.lang.Double`
  7. boolean 对应 `java.lang.Boolean`
  8. char 对应 `java.lang.Character`

* 思考 : java中提供的八种基本数据类型不够用吗? 为什么java中还要提供对应的包装类呢? `方便.`

  ![](D:\Java-figure\212.png)

* 八种基本数据类型对应的包装类之间的继承关系结构图 : 

  ![](D:\Java-figure\213.png)

* 包装类型的常用方法(以java.lang.Integer类型为例, 讲解八种类型) : 

  * Number类中6个公共方法 : 

    ![](D:\Java-figure\214.png)

  * Integer类的字段 : 

    ![](D:\Java-figure\215.png)

    1. 获取int类型的最大值和最小值(它们是静态字段, 所以可以直接通过`类名.`的方式调用) : `Integer.MAX_VALUE`, `Integer.MIN_VALUE`. 

       ![](D:\Java-figure\216.png)

    2. 以int推byte, Btye中也有最大值和最小值 : `Byte.MIN_VALUE`, `Btye.MAX_VALUE`.

       ![](D:\Java-figure\217.png)

  * 创建Integer类型的对象两种方式 : 

    ![](D:\Java-figure\220.png)

    ![](D:\Java-figure\218.png)

    1. 参数为int, int --> Integer;
    2. 参数为string, string --> Integer.

  * 注意 : 虽然可以将字符串转换成Integer类型, 但是该字符串也必须是"`数字字符串`".

  * Integer类中常用方法 : 

    1. `int intValue()` : Integer --> int (引用类型 -- > 基本类型).

    2. `static int parseInt(string s)` : string --> int. 在Double类中有`parseDouble(stirng s)`方法 : string --> double.

    3. `将int类型的十进制转换成2, 8, 16进制` : 

       ![](D:\Java-figure\221.png)

       ![](D:\Java-figure\222.png)

    4. `valueOf(int i)` : int --> Integer.

       ![](D:\Java-figure\223.png)

    5. `valueOf(string s)` : string --> Integer.

       ![](D:\Java-figure\224.png)

  * Integer, int和string三种类型相互转换 : 

    ![](D:\Java-figure\225.png)

    1. int --> Integer : `valueOf()`
    2. Integer --> int : `intValue()`
    3. string --> Integer : `valueOf()`
    4. Integer --> string : `toString()`
    5. string --> int : `parseInt()`
    6. int --> string : `+ ""`
    
  * `注意` : 包装类中很多字段和方法是`静态`的, 所以不需要创建对象, 直接通过`类.`的方式使用即可. 一般字段都是静态的, 方法中从Integer转换为其他类型时一般不是静态的, 所以需要创建对象才能引用.
  
* 自动装箱和自动拆箱

  * JDK5.0新特性 : 以下的特性适合JDK1.5版本之后的, 包括1.5. JDK1.4, 包括1.4在内之前的所有版本不能使用以下特性.

  * `自动装箱(auto_boxing)和自动拆箱(auto_unboxing)`

  * JDK5.0之前的 :

    ![](D:\Java-figure\226.png)

    * int --> Integer (装箱)
    * Integer --> int (拆箱)

  * JDK5.0之后, 包括5.0 : 

    ![](D:\Java-figure\227.png)

    * 自动装箱
    * 自动拆箱

    `注意` : Integer是类, 所以输出时会自动调用tostring方法, 所以上面图片中第五行代码输出的是一个字符串.

  * 深入自动装箱和自动拆箱

    ![](D:\Java-figure\228.png)

    ![](D:\Java-figure\229.png)

    ![](D:\Java-figure\230.png)

    1. 自动装箱和自动拆箱是程序编译阶段的一个概念, 和程序运行无关.
    2. 自动装箱和自动拆箱主要目的是方便程序员编码.

    `注意` : 比较两个integer类型的数据是否相等, 不能用"==", 要使用`equals方法`, integer已经重写了object中的equals方法.
    
    `注意` : 如果数据在(-128~127)之间, java中引入了一个"整型常量池", 在方法区中. 所以上面图片中使用==判断两个引用是否相等时才会出现true的情况. 该整型常量池只存储-128~127之间的数据.
    
    `注意` : 在方法区中有字符串常量池和整形常量池, 如果不使用new而直接赋值, 则从常量池中取值, 所以它们的引用中存储的地址是相同的; 如果使用new, 则会在堆中创建对象, 则引用中存储的地址是不同的.

#### 5. 日期类型

* 常用日期类有三种 : 
  1. `java.util.Date`
  2. `java.text.SimpleDateFormat`
  3. `java.util.Calendar`

* `system.currentTimeMillis()` : 获取自1970年1月1日00时00分00秒000毫秒到当前的毫秒数.

* 获取系统当前时间一般使用`Date`类 : 

  * 可以通过date类的无参数构造方法获取系统当前时间 : `Date nowTime = new Date()`. 输出的结果的格式对外国人友好, 而且说明java.util.Date已经重写了object中的tostring方法. 只不过结果对于中国人讲不太容易理解. 所以引入`格式化`日期.
  * 引入`"格式化日期"` : java.util.Date --> String
  * 日期格式 : 年(y), 月(M), 日(d), 小时(H), 分(m), 秒(s), 毫秒(S).

* `java.text.SimpleDateFormat` : 是一个类, 它是日期格式化类, 专门用来格式化日期的(java.util.Date).

  * `SimpleDateFormat类的一个构造方法` : 

    ![](D:\Java-figure\231.png)

  * `SimpleDateFormat类中有一个方法` : `string format(Date date)`(将一个Date格式化为日期/时间字符串.)

    ![](D:\Java-figure\232.png)

  * 得到格式化日期的流程 : 

    ![](D:\Java-figure\233.png)

* `获取特定的日期` : 将给定的string日期转换成日期类型Date(string --> Date)

  * `注意` : 使用SimpleDateFormat类创建日期格式化对象时, 格式不能随意, 应该和给定的字符串格式相同.

  * simpledateformat类的父类型中有一个方法 : `Date parse(strtime)` (将字符串转换成日期类型.)

  * `注意` : `parse`方法抛出异常, 所以需要处理.

    ![](D:\Java-figure\235.png)

  * 获取特定的日期的流程 : 

    ![](D:\Java-figure\236.png)

* Date类中有一个构造方法 : `Date d = new Date(long millis)` (可以得到一个自1970年1月1日00时00分00秒000毫秒加上millis毫秒数后的Date日期.) (可以用来获取当前系统时间的前...时间.)

  ![](D:\Java-figure\237.png)

* 日历类 : `Calendar` : 该类中有字段有方法.

  ![](D:\Java-figure\238.png)

  * 日历类中常用的字段 : 

    ![](D:\Java-figure\239.png)

#### 6. 数字类

* `java.text.DecimalFormat`和`java.math.BigDecimal`

* 关于`java.text.DecimalFormat` : 

  ![](D:\Java-figure\240.png)

  * 数字格式元素 : `#`(任意数字); `,`(千分位); `.`(小数点); `0`(不够补0).
  * 格式化 : Number --> string

* 关于`java.math.BigDecimal`

  ![](D:\Java-figure\241.png)

  * `该类型数据精确度极高, 适合做财务软件`, 财务软件中double类型精确度太低.
  * 注意 : 不能使用创建的两个BigDecimal对象进行加法运算, 因为两个引用类型不能做加法运算(`+`). 必须调用方法执行加法运算(`add`方法).

#### 7. 随机数Random

* 生成随机数

  ![](D:\Java-figure\243.png)

* 生成5个不重复的随机数[1-5] : 

  ![](D:\Java-figure\247.png)

  ![](D:\Java-figure\248.png)

#### 8. 枚举类型enum

* 需求 : 定义一个方法, 该方法的作用使计算两个int类型数据的商. 如果计算成功则该方法返回1, 如果执行失败则该方法返回0.

  * 程序执行成功, 但是该程序存在风险, 分析 : 存在什么风险? (`返回类型为int, 太过宽泛, 即使返回值错写为其他整型, 在编译时也查不出什么错误.`)

    ![](D:\Java-figure\244.png)

  * 程序中的问题能在编译阶段解决的, 绝对不会放在运行期解决. 所以以下程序可以引入"枚举类型".

    ![](D:\Java-figure\245.png)

* 注意 : `规范要求枚举类型中的值必须是大写, 而且是有限的`. 枚举类型生成的文件也是`class`文件.

  ![](D:\Java-figure\246.png)



# 数组

#### 1. 纲要

1. 数组概要
2. 一维数组的声明和使用
3. 二维数组的声明和使用
4. 数组的排序
5. 数组的查找
6. Arrays工具类
7. 数组的应用

#### 2. 数组概要

* 数组：

  ![](D:\Java-figure\279.png)

  ![](D:\Java-figure\280.png)

  1. 数组是一种引用类型, 数组拿首元素的内存地址作为数组对象的内存地址;
  2. 数组是一种简单的数据结构, 线性的结构;
  3. 数组是一个容器, 可以用来存储其他元素, 数组是可以存储任意数据类型的元素;
  4. 数组分为 : 一维数组, 二维数组, 三维数组, 多维数组 ...
  5. 数组中存储的元素类型是统一的, 每一个元素在内存中所占的空间大小是相同的;
  6. 数组长度不可改变, 数组一旦创建长度是不可变的, 固定的;
  7. 数组中每一个元素都是由下标的, 有索引的, 从0开始, 任何一个数组都有一个length属性用来获取数组中元素的个数;
  8. 数组通过元素的下标获取元素 : 取得第一个元素(a1[0]), 取得最后一个元素(a1[a1.length-1]);
  9. 数组优点 : 查找效率高; 数组缺点 : 随意的增删元素效率比较低.
     * 数组优点 : 知道数组的首元素的内存地址, 要查找的元素只要知道下标就可以快速的计算出偏移量, 通过首元素的内存地址加上偏移量快速计算出要查找元素的内存地址, 通过内存你地址快速定位钙元素, 所以数组查找元素的效率较高.
     * 数组缺点 : 随机的对数组进行增删元素, 当增加元素的时候, 为了保证数组中元素在空间存储上是有序的, 所以被添加元素位置后面的所有元素都要向后移动. 删除元素也是, 后面所有的元素要向前移动. 所以数组的增删元素的效率很低.


#### 3. 一维数组的声明和使用

* 初始化一维数组有两种方式 : 

  1. 静态初始化 : 

     ![](D:\Java-figure\281.png)

  2. 动态初始化 : 

     ![](D:\Java-figure\282.png)

     1. 动态初始化一维数组, 会先在堆内存中分配这个数组, 并且数组中每一个元素都采用默认值.

        * byte, short, int, long    0
        * float, double    0.0
        * boolean    false
        * char    \u0000
        * 引用    null

     2. `注意` : 空指针异常. 因为引用类型的数组默认值是null. 如果直接调用tostring方法就会出现空指针异常, 但是通过println输出时就不会出现空指针异常.

        ![](D:\Java-figure\283.png)

        原因 : println方法会自动调用valueOf方法, valueOf调用tostring方法, valueOf会处理空指针异常.

        ![](D:\Java-figure\284.png)


* 什么时候使用动态初始化, 什么时候使用静态初始化?

  ![](D:\Java-figure\285.png)

  1. 无论是动态初始化还是静态初始化, 最终的内存分布都是一样的.
  2. 如果在创建数组的时候, 知道数组中应该存储什么数据, 这个时候当然采用静态初始化方式. 如果在创建数组的时候, 无法预测到数组中存储什么数据, 只是先开辟空间, 则使用动态初始化方式.

* 深入一维数组 : 创建一个数组, 这个数组既可以存储Dog, 也能存储Cat.

  ![](D:\Java-figure\286.png)

  ![](D:\Java-figure\287.png)
  
* 方法调用的时候, 也可以这样传递一个数组 : 

  ![](D:\Java-figure\290.png)

* 关于main方法中的参数列表`string[] args` : 

  ![](D:\Java-figure\288.png)

  ![](D:\Java-figure\289.png)

  1. `string[] args`是专门用来接受命令行参数的;
  2. 例如 : `java arraytest07 abc def aaa` JVM在调用arraytest07类的main方法值之前, 先将"abc def aaa"这个字符串以`空格`的方式分割, 然后存储在string数组中.

* 关于数组拷贝

  * system类下有一个复制数组的方法 :  

    ![](D:\Java-figure\291.png)

    ![](D:\Java-figure\292.png)

    ![](D:\Java-figure\293.png)

#### 4. 二维数组的声明和使用

* 二维数组的特点 :

  ![](D:\Java-figure\294.png)

  ![](D:\Java-figure\295.png)

  1. 二维数组是一个特殊的一维数组;
  2. 特殊的一维数组, 特殊在这个一维数组中每一个元素都是"一维数组".

* 关于二维数组的动态初始化

  ![](D:\Java-figure\296.png)

  ![](D:\Java-figure\297.png)

#### 5. 数组的排序

1. 冒泡排序

   ![](D:\Java-figure\299.png)

   ![](D:\Java-figure\300.png)

2. 选择排序

   ![](D:\Java-figure\301.png)

   ![](D:\Java-figure\302.png)

   

#### 6. 数组的查找

* 二分法查找(折半查找) : 二分法查找是建立在已经排序的基础之上的, 要求数组中元素从小到大排序, 而且没有重复元素.

  ![](D:\Java-figure\305.png)

  ![](D:\Java-figure\303.png)

  ![](D:\Java-figure\304.png)

#### 7. Arrays工具类

![](D:\Java-figure\298.png)

* `java.util.Arrays` : 此类包含用来操作数组(排序, 二分查找等)的各种方法. 此类还包含一个允许将数组作为列表来查看的静态工厂. 
* `Arrays.sort()` : 从小到大排序. 
* `Arrays.binarySearch()` : 二分查找.

#### 8. 数组的应用

1. 接受用户键盘输入

   ![](D:\Java-figure\306.png)

2. 使用数组模拟栈Stack

   ![](D:\Java-figure\307.png)

   ![](D:\Java-figure\308.png)

   ![](D:\Java-figure\309.png)

   ![](D:\Java-figure\310.png)



# 多线程

#### 1. 纲要

1. 多线程的基本概念
2. `线程的创建和启动`
3. `线程的生命周期`
4. 线程的调度
5. 线程控制
6. `线程的同步`
7. 守护线程
8. 定时器的使用
9. windows的任务计划

#### 2. 多线程的基本概念

* 什么是进程?

  ​		一个进程对应一个应用程序. 例如 : 在windows操作系统启动word就表示启动了一个进程. 在java的开发环境下启动JVM, 就表示启动了一个进程. 现代的计算机都是支持多进程的, 在同一个操作系统中, 可以同时启动多个进程.

* 多进程有什么作用?

  * 单进程计算机只能做一件事. 例如 : 玩电脑, 一边玩游戏(游戏进程)一边听音乐(音乐进程). 对于单核计算机来讲, 在同一个时间点上, 游戏进程和音乐进程是同时在运行吗? 不是, 因为计算机的CPU只能在某个时间点上做一件事, 由于计算机将在"游戏进程"和"音乐进程"之间频繁的切换执行. 切换速度极高, 人类感觉游戏和音乐在同时进行.
  * `多进程的作用不是提高执行速度, 而是提高CPU的使用率.`
  * 进程和进程之间的内存是`独立`的.

* 什么是线程?

  ​		线程是一个进程中的执行场景, 一个进程可以启动多个线程.

* 多线程有什么作用?

  * `多线程不是为了提高执行速度, 而是提高应用程序的使用率.`
  * `线程和线程共享"堆内存和方法区内存", 栈内存是独立的, 一个线程一个栈.`
  * 可以给现实世界中的人类一种错觉 : 感觉多个线程在同时并发执行.
  
* 使用进程和线程分析java程序的运行

  * java命令会启动java虚拟机, 启动JVM, 等于启动了一个应用程序, 表示启动了一个进程. 该进程会自动启动一个"`主线程`", 然后主线程去调用某个类的main方法, 所以main方法运行在主线程中, 在此之前的所有程序都是单线程的.

  * 例子 : 

    ![](D:\Java-figure\311.png)

    ![](D:\Java-figure\312.png)

#### 3. 线程的创建和启动

* 在java语言中实现多线程的第一种方式 : 

  ![](D:\Java-figure\313.png)

  ![](D:\Java-figure\314.png)

  ![](D:\Java-figure\315.png)

  * 步骤 : 
    1. 第一步 : `继承java.lang.Thread`;
    2. 第二步 : `重写run方法`.
  * 三个知识点 :
    1. 如何定义线程? `继承Thread, 重写run方法`
    2. 如何创建线程? `new一个`
    3. 如何启动线程? `使用start()方法  : 进程对象.start()`
  * `t.start()` : 启动t线程, 这行代码执行瞬间结束. 告诉JVM再分配一个新的栈给t线程. run方法不需要程序员手动调用, 系统线程启动后自动调用run方法, run方法中写的就是要在其他线程中做的事情.
  * 有了多线程之后, main方法结束只是主线程栈中没有方法栈帧了. 但是其他线程或者其他栈中还有栈帧. main方法结束, 程序可能还在运行.

* java中实现线程的第二种方式 :

  ![](D:\Java-figure\317.png)

  * 步骤 :

    1. 第一步 : 写一个类实现`java.lang.Runnable`(接口)
    2. 第二步 : 实现run方法.

  * 注意 : 创建线程时, 要使用一个参数为runnable类型的Thread构造方法.

    ![](D:\Java-figure\316.png)

* 推荐使用第二种方式. 因为一个类实现接口之外保留了类的继承.

* 总结 : 实现一个功能可以有两种方式, 第一种就是自定义一个类直接继承功能类, 重写功能类中相应的方法, 然后创建功能类的对象(使用了多态); 第二种就是自定义一个类实现功能类的特性(接口), 表示自定义的类具有了相应的特性, 然后将自定义类的对象作为功能类的构造方法的参数(使用了多态)来创建功能类的对象(使用了多态).

#### 4. 线程的生命周期

![](D:\Java-figure\318.png)

![](D:\Java-figure\319.png)

#### 5. 线程的调度与控制

​		通常我们的计算机只有一个CPU, CPU在某一个时刻只能执行一条指令, 线程只有得到CPU时间片, 也就是使用权, 才可以执行指令. 在单CPU的机器上线程不是并行运行的, 只有在多个CPU上线程才可以并行运行. Java虚拟机要负责线程的调度, 取得CPU的使用权, 目前有两种调度模型: `分时调度模型`和`抢占式调度模型`, java使用抢占式调度模型.

​		`分时调度模型` : 所有线程轮流使用CPU的使用权, 平均分配每个线程占用CPU的时间片.

​		`抢占式调度模型` : 优先让优先级高的线程使用CPU, 如果线程的优先级相同, 那么会随机选择一个, 优先级高的线程获取的CPU时间片相对多一些.

##### 5.1 线程优先级

* 线程优先级主要分三种 : MAX_PRIORITY(最高级 : 10); MIN_PRIORITY(最低级 : 1); NORM_PRIORITY(标准 : 5)默认. 线程优先级从1到10.

* 如何获取当前线程对象? 

  * 使用Thread类中的一个静态方法`currentThread()`. Thread类中有一个成员方法`getName()`, 可以获得该线程的名称. `currentThread()`这个静态方法在哪个线程中使用则返回的就是该线程的引用. 可以使用`setName()`方法给线程起名字.

    ![](D:\Java-figure\322.png)

    ![](D:\Java-figure\323.png)

  * 三个方法:

    1. 获取当前线程对象 : Thread.currentThread();

       ![](D:\Java-figure\320.png)

    2. 给线程起名 : t.setName("t1");

    3. 获取线程的名字 : t.getName().

       ![](D:\Java-figure\321.png)
  
* 获取和设置线程的优先级 :

  ![](D:\Java-figure\324.png)

  ![](D:\Java-figure\325.png)

* Thread中有三个静态字段 : 

  ![](D:\Java-figure\326.png)

  ![327](D:\Java-figure\327.png)

##### 5.2 Thread.sleep

* sleep方法的基本说明 :

  1. `Thread.sleep(毫秒)`.

  2. sleep方法是一个静态方法.

  3. 该方法的作用 : 阻塞当前线程, 腾出CPU, 让给其他线程.

  4. 注意 : sleep抛出编译时异常, 所以需要处理异常, 不能在重写的run方法那儿抛出异常, 因为在Thread类中run方法根本就不抛出异常, 所以继承过来重写的run就不能抛出异常(因为它不能抛出比父类中被重写的方法更宽泛的异常). (`Thread中的run方法不抛出异常, 所以重写run方法之后, 在run方法的声明位置上不能使用throws, 所以run方法中的异常只能用try...catch...`)

     ![](D:\Java-figure\328.png)

     ![](D:\Java-figure\329.png)

  5. 面试题 : 

     ![](D:\Java-figure\330.png)
  
* 某线程正在休眠, 如何打断它的休眠 : 

  ![333](D:\Java-figure\333.png)

  ![](D:\Java-figure\332.png)

  * 使用`interrupt()`方法.

  ![](D:\Java-figure\331.png)

  * 这种中断方式依靠的是`异常处理机制`. 也就是使得Processor类中的`Thread.sleep()`语句发生InterruptedException异常.

* 如何正确的更好的终止一个正在执行的线程 : (需求 : 线程启动5s之后终止)

  ![](D:\Java-figure\334.png)
  
  ![335](D:\Java-figure\335.png)

##### 5.3 Thread.yield

![](D:\Java-figure\336.png)

![337](D:\Java-figure\337.png)

1. 该方法是一个静态方法.

2. 作用 : 它与sleep()类似, 只是不能由用户指定暂停多长时间, 并且yield()方法只能让`同优先级`的线程有执行的机会, 也就是让位. 让位时间不固定. 
3. 和sleep方法相同, 就是yield时间不固定.

##### 5.4 Thread.join

![](D:\Java-figure\338.png)

![339](D:\Java-figure\339.png)

* 它是一个成员方法.
* 作用 : 线程的合并. `t.join()`在哪个线程中, t就和哪个线程合并, 合并之后就是单线程程序.

#### 6. 线程同步(加锁)(`最重要`)

* 两种编程模型(以t1和t2线程为例) :

  1. [异步编程模型]() : t1线程执行t1的, t2线程执行t2的, 两个线程之间谁也不等谁.
  2. [同步编程模型]() : t1线程和t2线程执行, 当t1线程必须等t2线程执行结束之后, t1线程才能执行, 这是同步编程模型.

* 什么时候要同步呢? 为什么要引入线程同步呢?

  1. 为了[`数据安全`. 尽管应用程序的使用率降低, 但是为了保证数据是安全的, 必须加入线程同步机制. 线程同步机制使程序变成了(等同)单线程.
  2. 什么条件下要使用线程同步呢?
     * 第一 : 必须是`多线程环境`
     * 第二 : 多线程环境`共享同一个数据`
     * 第三 : 共享的数据涉及到`修改操作`.

* 取款例子

  * 以下程序不使用线程同步机制, 多线程同时对同一个账户进行取款操作, 会出现什么问题?

    ![](D:\Java-figure\340.png)

    ![341](D:\Java-figure\341.png)

    ![342](D:\Java-figure\342.png)

    ![343](D:\Java-figure\343.png)

  * 以下程序使用线程同步机制保证数据的安全.

    * 使用 [synchronized(共享对象){}]() 把需要同步的代码放到同步语句块中. 大括号中只能放一个线程.

    * 注意 : synchronized关键字添加到成员方法上, 线程拿走的也是this的对象锁.

    * 原理 : t1线程和t2线程.

      1. t1线程执行到此处, 遇到了synchronized关键字, 就会去找this的对象锁, 如果找到this对象锁, 则进入同步语句块中执行程序. 当同步语句块中的代码执行结束后, t1线程归还this的对象锁.
      2. 在t1线程执行同步语句块的过程中, 如果t2线程也过来执行以下代码, 也遇到synchronized关键字, 所以也去找this的对象锁, 但是该对象锁被t1线程持有, 只能在这等待this对象的归还.

    * `synchronized`关键字有两种使用方式, 一种是加载同步语句块上; 另一种是加在方法上. 推荐使用第一种方式, 因为方法中可能有不需要同步的代码.

    * 如果两个线程共享一个对象, 则将该对象作为构造方法的参数传入来实现共享.

      ![](D:\Java-figure\346.png)

    ![](D:\Java-figure\344.png)

    ![](D:\Java-figure\345.png)

* 面试题 : 

  ![348](D:\Java-figure\348.png)

  ![349](D:\Java-figure\349.png)

  ![](D:\Java-figure\347.png)

  ![350](D:\Java-figure\350.png)
  
* 类锁, 类只有一个, 所以锁是类级别的, 只有一个.

  ![353](D:\Java-figure\353.png)

  ![352](D:\Java-figure\352.png)

  ![](D:\Java-figure\351.png)

  * 修改代码 : 

    ![](D:\Java-figure\354.png)

    ![355](D:\Java-figure\355.png)

* 总结 : 线程同步中一共有两种锁, 一种是对象锁, 对象级别的, 加到成员方法或者需要同步的代码块上, 但是如果加到方法上, 则该方法中的所有代码都需要同步, 加到代码块上则只是让需要的代码进行同步, 该方法中的其他代码不影响, 一个对象只有一个对象锁, 当多个线程访问该对象中的同步代码块时, 就会触发该对象锁, 实现同步; 另一种是类锁, 类级别的, 加到静态方法上, 一个类只有一个类锁, 当多个线程方法该类中的同步代码块时, 就会触发类锁, 实现同步.

* 死锁 : 

  ![](D:\Java-figure\356.png)

  ![357](D:\Java-figure\357.png)

  ![358](D:\Java-figure\358.png)

#### 7. 守护线程

* 从线程上可以分为 : `用户线程`(上面都是用户线程)和`守护线程`. 守护线程是这样的, 所有的用户线程结束生命周期, 守护线程才会结束生命周期, 只要有一个用户线程存在, 那么守护线程就不会结束, 例如java中著名的`垃圾回收器`就是一个守护线程, 只有应用程序中所有的线程结束, 它才会结束.

* 守护线程, `其他所有的用户线程结束, 则守护线程退出!` 守护线程一般都是无限执行的. 

  ![](D:\Java-figure\360.png)

  ![361](D:\Java-figure\361.png)

* 可以通过Thread类中的`setDaemon(true)`这个成员方法将用户线程修改为守护线程.

  ![](D:\Java-figure\359.png)

#### 8. Timer定时器

* 定时器的作用 : 每隔一段固定的时间执行一段代码.

* 具体步骤 : 

  ![366](D:\Java-figure\366.png)

  1. 创建定时器

     ![](D:\Java-figure\362.png)

  2. 指定定时任务

     ![](D:\Java-figure\363.png)

     ![](D:\Java-figure\364.png)

     ![365](D:\Java-figure\365.png)

* Object类中和线程相关的几个方法 : 

  ![](D:\Java-figure\367.png)



# 注解

#### 1. 注解概述

* **[注解的基本说明]()** :

  1. 注解, 或者叫注释类型, 英文单词是: Annotation;

  2. 注解`Annotation`是一种**引用数据类型**. 编译之后也是生成`xxx.class`文件;

  3. 怎么自定义注释呢? 语法格式?

     `[修饰符列表] @interface 注解类型名 {}`

  ```java
  /*
  自定义注解: MyAnnotation
  */
  public @interface MyAnnotation {
       
  }
  ```

  4. 注解怎么使用, 用在什么地方?
     * 第一: 注解使用时的语法格式是: `@注解类型名`
     * 第二: 注解可以出现在**类上, 属性上, 方法上, 变量上等, 注解还可以出现在注解类型上**. 

  ```java
  //默认情况下, 注解可以出现在任意位置
  @MyAnnotation
  public class AnnotationTest01 {
      @MyAnnotation
      private int no;
      @MyAnnotation
      public AnnotationTest01() {}
      @MyAnnotation
      public static void m1() {
          @MyAnnotation
          int i = 100;
      }
      @MyAnnotation
      public void m2(@MyAnnotation String name) {
          
      }
  }
  
  @MyAnnotation
  interface MyInterface {
      
  }
  
  @MyAnnotation
  enum Season {
      SPRING, SUMMER, AUTUMN, WINTER
  }
  ```

  ```java
  //注解修饰注解
  @MyAnnotation
  public @interface OtherAnnotation {
      
  }
  ```

#### 2. JDK的内置注解

* **[JDK内置了哪些注解(java.lang包下的注释类型, 掌握前两个)]()** : 

  1. **Override** : 表示一个方法声明打算重写超类中的另一个方法声明.
  2. **Deprecated** : 用@Deprecated注释的程序元素, 不鼓励程序员使用这样的元素, 通常是因为它很危险或存在更好的选择.
  3. **SuppressWarnings** : 指示应该在注释元素(以及包含在该注释元素中的所有程序元素)中取消显示指定的编译器警告.

* **[Override注解]()** :

  ```java
  /*
  关于JDK lang包下的Override注解
  源代码:
  public @interface Override {
  
  }
  
  标识性注解, 给编译器做参考的.
  编译器看到方法上有这个注解的时候, 编译器会自动检查该方法是否重写了父类的方法.
  如果没有重写, 报错.
  这个注解只是在编译阶段起作用, 和运行期无关!
  */
  
  //@Override这个注解只能注解方法
  //@Override这个注解是给编译器参考的, 和运行阶段没有关系
  //凡是java中的方法带有这个注解的, 编译器都会进行编译检查, 如果这个方法不是重写父类的方法, 编译器报错.
  public class AnnotationTest02 {
      
      @Override
      public String toString() {
          return "toString";
      }
  }
  ```

* **[元注解]()** :

  * **什么是元注解** : 用来标注"注解类型"的注解称为元注解.
  * **常见的元注解有哪些** : 
    1. Target
    2. Retention
  * **关于Target注解** :
    1. 这是一个元注解, 用来标注"注解类型"的注解;
    2. 这个Target注解用来标注"被标注的注解"可以出现在哪些位置上.
    3. `@Target(ElementType.METHOD)` : 表示"被标注的注解"只能出现在方法上.
    4. `@Target(value={CONSTRUCTOR,FIELD,LOCAL_VARIABLE,METHOD,PACKAGE,MOOULE,PARAMETER,TYPE})` : 表示该注解可以出现在: 构造方法上, 字段上, 局部变量上, 方法上, ... , 类上...
  * **关于Retention注解** :
    1. 这是一个元注解, 用来标注"注解类型"的注解;
    2. 这个Retention注解用来标注"被标注的注解"最终保存在哪里;
    3. `@Retention(RetentionPolicy.SOURCE)` : 表示该注解只被保留在java源文件中;
    4. `@Retention(RetentionPolicy.CLASS)` : 表示该注解被保存在class文件中;
    5. `@Retention(RetentionPolicy.RUNTIME)` : 表示该注解被保存在class文件中, 并且可以被反射机制所读取.

  ```java
  @Target(ElementType.METHOD)
  @Retention(RetentionPolicy.SOURCE)
  public @interface Override {
      
  }
  ```

* **[Deprecated注解]()** : 

  ```java
  //表示这个类已过时
  //Deprecated这个注解标注的元素已过时.
  //这个注解主要是向其他程序员传达一个信息, 告知已过时, 有更好的解决方案存在.
  @Deprecated
  public class AnnotationTest03 {
      public static void main(String[] args) {
          AnnotationTest03.doSome();
      }
      
      public void doSome() {
          System.out.println("do something!");
      }
      
      public static void doOther() {
          System.out.println("do other...");
      }
  }
  ```

#### 3. 注解中的属性

* **[注解中定义属性]()** :

  ```java
  public @interface MyAnnotation {
      
      /**
       * 我们通常在注解当中可以定义属性, 以下这个是MyAnnotation的name属性.
       * 看着像一个方法, 但实际上我们称之为属性name.
       * @return
       */
      String name();
      
      int age() default 25; //属性指定默认值
  }
  ```

  ```java
  public class MyAnnotationTest {
      
      //报错的原因: 如果一个注解当中有属性, 那么必须给属性赋值. (除非该属性使用default指定了默认值.)
      /*
      @MyAnnotation
      public void doSome() {
          
      }
      */
      
      //@MyAnnotation(属性名=属性值, 属性名=属性值, ...)
      @MyAnnotation(name="张三")
      public void doSome() {
          
      }
  }
  ```

* **[属性是value时可以省略]()** : 

  ```java
  public @interface MyAnnotation {
      
      /*
      指定一个value属性
      */
      String value();
      
      //String email();
  }
  ```

  ```java
  /*
  如果一个注解的属性的名字是value, 并且只有一个属性的话, 在使用的时候, 该属性名可以省略.
  */
  public @interface MyAnnotationTest {
      
      //报错原因: 没有指定属性的值, 如果属性名是name, 不能省略.
      /*
      @MyAnnotation
      public void doSome() {
          
      }
      */
      
      @MyAnnotation(value="haha")
      public void doSome() {
          
      }
      
      @MyAnnotation("haha")
      public void doOther() {
          
      }
  }
  ```

* **[属性的类型]()** :

  ```java
  public @interface MyAnnotation {
      /*
      注解当中的属性可以是哪一种类型?
      	属性的类型可以是:
      		byte short int long float double boolean char String Class 枚举类型
      		以及以上每一种的数组形式.
      */
      int value1();
      String value2();
      int[] value3();
      String[] value4();
      Season value5();
      Season[] value6();
      Class value7();
      Class[] parameterType();
      Class[] parameterTypes();
  }
  ```

  ```java
  public enum Season {
      SPRING, SUMMER, AUTUMN, WINTER
  }
  ```

  ```java
  public @interface OtherAnnotation {
      int age();
      String[] email();
      Season[] seasonArray(); //Season是枚举类型
  }
  ```

  ```java
  public class OtherAnnotationTest {
      
      //数组是大括号
      @OtherAnnotation(age=25, email={"zhangsan@123.com", "zhangsan@sohu.com"})
      public void doSome() {
          
      }
      
      //如果数组中只有一个元素: 大括号可以省略
      @OtherAnnotation(age=25, email="zhangsan@sohu.com", seasonArray={Season.SPRING, Season.SUMMER})
      public void doOther() {
          
      }
  }
  ```

* **[Retention的源代码]()** :

  ```java
  //元注解
  public @interface Retention {
      //属性
      RetentionPolicy value(); //RetentionPolicy是枚举类型
  }
  
  //RetentionPolicy的源代码:
  public enum RetentionPolicy {
      SOURCE, CLASS, RUNTIME
  }
  
  //@Retention(value=RetentionPolicy.RUNTIME)
  @Retention(RetentionPolicy.RUNTIME)
  public @interface MyAnnotation {
      
  }
  ```

* **[Target的源代码]()** :

  ```java
  //元注解
  public @interface Target {
      ElementType[] value();
  }
  
  //ElementType的源代码:
  public enum ElementType {
      TYPE, FIELD, METHOD, PARAMETER, CONSTRUCTOR, ...
  }
  ```

#### 4. 反射注解

* **[反射注解]()** :

  ```java
  //只允许该注解可以标注类, 方法
  @Target({ElementType.TYPE, ElementType.METHOD})
  //希望这个注解可以被反射
  @Retention(RetentionPolicy.RUNTIME)
  public @interface MyAnnotation {
      
      /*
      value属性
      */
      String value() default "北京大兴区";
      
  }
  ```

  ```java
  @MyAnnotation
  public class MyAnnotationTest {
      
      //@MyAnnotation
      int i;
      
      //@MyAnnotation
      public MyAnnotationTest() {
          
      }
  }
  ```

  ```java
  public class ReflectAnnotationTest {
      public static void main(String[] args) throws Exception {
          //注意: 注解在类上.
          //第一步: 获取类
          //第二步: 获取该类上的注解
          
          //获取这个类
          Class c = Class.forName("com.bjpowernode.java.annotation5.MyAnnotationTest");
          //判断类上是否有@MyAnnotation
          System.out.println(c.isAnnotationPresent(MyAnnotation.class)); //true
          if(c.isAnnotationPresent(MyAnnotation.class)) {
              //获取该注解对象
              MyAnnotation myAnnotation = (MyAnnotation)c.getAnnotation(MyAnnotation.class);
              System.out.println("类上面的注解对象" + myAnnotation);
              //获取注解对象的属性怎么办? 和调接口没区别.
              String value = myAnnotation.value();
              System.out.println(value);
          }
          
          //判断String类上是否存在这个注解
          Class stringClass = Class.forName("java.lang.String");
          System.out.println(stringClass.isAnnotationPresent(MyAnnotation.class)); //false
      }
  }
  ```

* **[通过反射获取注解对象属性的值]()** :

  ```java
  @Retention(RetentionPolicy.RUNTIME)
  @Target(ElementType.METHOD)
  public @interface MyAnnotation {
      String username();
      String password();
  }
  ```

  ```java
  public class MyAnnotationTest {
      
      @MyAnnotation(username="admin", password="123")
      public void doSome() {
          
      }
      
      public static void main(String[] args) {
          //获取MyAnnotationTest的doSome()方法上面的注解信息. 注意: 注解在类的方法上.
          //第一步: 获取类
          //第二步: 获取该类的doSome()方法
          //第三步: 获取doSome()方法上的注解
          Class c = Class.forName("com.bjpowerndoe.java.annotation6.MyAnnotationTest");
          //获取doSome()方法
          Method doSomeMethod = c.getDeclaredMethod("doSome");
          //判断该方法上是否存在这个注解
          if(doSomeMethod.isAnnotationPresent(MyAnnotation.class)) {
              MyAnnotation myAnnotation = doSomeMethod.getAnnotation(MyAnnotation.class);
              System.out.println(myAnnotation.username());
              System.out.println(myAnnotation.password());
          }
      }
  }
  ```

* **[注解在开发中有什么用]()** :

  ```java
  /**
  需求: 
  	假设有这样一个注解, 叫做: @Id
  	这个注解只能出现在类上面, 当这个类上有这个注解的时候, 要求这个类中必须有一个int类型的id属性, 如果没有这个属性就报异常, 如果有这个属性则正常执行!
  */
  
  //表示这个注解只能出现在类上面
  @Target(ElementType.TYPE)
  //该注解可以被反射机制读取到
  @Retention(RetentionPolicy.RUNTIME)
  public @interface Id {
      
  }
  
  //这个注解@Id用来标注类, 被标注的类中必须有一个类型的id属性, 没有就报异常.
  ```

  ```java
  //注解在程序员当中等同于一种标记, 如果这个元素上有这个注解怎么办, 没有这个注解怎么办.
  @Id
  public class User {
      int id;
      String name;
      String password;
  }
  ```

  ```java
  public class Test {
      public static void main(String[] args) throws Exception {
          //获取类
          Class userClass = Class.forName("com.bjpowernode.java.annotation7.User");
          boolean isOk = false; //给一个默认的标记
          //判断类上是否存在Id注解
          if(userClass.isAnnotationPresent(Id.class)) {
              //当一个类上面有@Id注解的时候, 要求类中心必须存在int类型的id属性
              //如果没有int类型的id属性则包异常
              //获取类的属性
              Field[] fields = userClass.getDeclaredFields();
              for(Field field : fields) {
                  if("id".equals(field.getName()) && "int".equals(field.getType().getSimpleName())) {
                      //表示这个类是合法的类. 有@Id注解, 则这个类中必须有int类型的id
                      isOk = true; //表示合法
                      break;
                  }
              }
              
              //判断是否合法
              if(!isOk) {
                  throw new HasNotIdPropertyException("被@Id注解标注的类中必须要有一个int类型的id属性!");
              }
          }
      }
  }
  ```

  ```java
  //自定义异常
  public class HasNotIdPropertyException extends RuntimeException {
      public HasNotIdPropertyException() {}
      public HasNotIdPropertyException(String s) {
          super(s);
      }
  }
  ```



# 反射机制

#### 1. 反射机制概述

* **[反射机制有什么用?]()**
  * 通过java语言中的反射机制可以**操作字节码文件**. 优点类似于黑客(可以读和修改字节码文件). 通过反射机制可以操作代码片段(class文件).
  * 反射机制可以使得程序**更加灵活**.
* **[反射机制的相关类在哪个包下?]()**
  * `java.lang.reflect.*;`
* **[反射机制相关的重要类还有哪些?]()**
  * `java.lang.Class` : 代表整个字节码, 代表一个类型, 代表整个类.
  * `java.lang.reflect.Method` : 代表字节码中的方法字节码, 代表类中的方法.
  * `java.lang.reflect.Constructor` : 代表字节码中的构造方法字节码, 代表类中的构造方法.
  * `java.lang.reflect.Field` : 代表字节码中的属性字节码, 代表类中的成员变量(静态变量+实例变量).

#### 2. 获取Class的三种方式

* **[说明]()** : 

  * 要操作一个类的字节码, 需要先获取到这个类的字节码, 怎么获取java.lang.Class实例? 
  * 三种方式.

* **[第一种方式]()** :

  * 使用Class类中的一个静态方法: `forName()`. `Class c = Class.forName("完整类名带包名");`

  * `Class.forName()`:

    1. **静态方法**.
    2. 方法的参数是一个**字符串**.
    3. 字符串需要是一个**完整类名**.
    4. 完整类名必须带有**包名**. java.lang包也不能省略.
    5. 该静态方法**抛出异常**, 所以需要处理异常.

  * 实例: 

    ```java
    Class c1 = Class.forName("java.lang.String"); //c1代表String.class文件, 或者说c1代表String类型.
    Class c2 = Class.forName("java.lang.Integer"); //c2代表Integer类型
    Class c3 = Class.forName("java.util.Date"); //c3代表Date类型
    Class c4 = Class.forName("java.lang.System"); //c4代表System类型
    ```

* **[第二种方式]()** :

  * java中任何一个对象都有一个方法: `getClass()`. `Class c = 对象.getClass();`

  * 实例:

    ```java
    String s = "abc";
    Class x = s.getClass(); //x代表String.clss字节码文件, x代表String类型.
    System.out.println(c1 == x); //true(==判断的是对象的内存地址)
    ```

  * c1 == x为true的原因的内存分析:

    ![](D:\Java-figure\368.png)

* **[第三种方式]()** : 

  * java语言中任何一种类型, 包括基本数据类型, 它都有`.class属性`. `Class c = 任何类型.class;` 

  * 实例:

    ```java
    Class z = String.class; //z代表String类型
    Class k = Date.class; //z代表Date类型
    Class f = int.class; //z代表int类型
    Class e = double.class; //z代表double类型
    ```

#### 3. 反射机制的使用

* **[通过反射实例化对象]()** :

  * 使用Class类中的一个成员方法: `newInstance()`. 该方法只会调用User类的**无参数构造方法**. 所以要把User类的无参数构造写出来. 如果只定义User类的有参数构造方法, 那么无参数构造方法就没有了, 就会有异常.
  * **如果构造方法发生了重载, 就要创建无参构造方法, 否则会报错.**

  ```java
  /*
  获取到Class, 能干什么?
      通过Class的newInstance()方法来实例化对象.
      注意: newInstance()方法内部实际上调用了无参数构造方法, 必须保证无参数构造方法存在才可以.
  */
  public class ReflectTest02 {
      public static void main(String[] args) {
          try {
              //通过反射机制, 获取Class, 通过Class来实例化对象
              Class c = Class.forName("com.bjpowernode.java.bean.User"); //c代表User类型
              
              //newInstance()这个方法会调用User这个类的无参数构造方法, 完成对象的创建.
              //重点是: newInstance调用的是无参数构造, 必须保证无参数构造方法是存在的!
              Object obj = c.newInstance();
              
          } catch(ClassNotFoundException e) {
              e.printStackTrace();
          }
      }
  }
  ```

* **[通过读属性文件实例化对象]()** :

  * 反射机制更加灵活, 灵活在哪里呢? 
  * 如果在classinfo.properties属性配置文件中修改值, 则这段代码最后产生的对象类型也会变化.
  * java代码写一遍, 在不改变java源代码的基础上, 可以做到不同对象的实例化, 非常之灵活.
  * 符合OCP原则: 对扩展开放, 对修改关闭.

  ```java
  /*
  验证反射机制的灵活性.
  
  后期要学习的是高级框架, 而工作过程中, 也都是使用高级框架.
  包括: ssh  ssm
      spring springMVC Mybatis
      spring struts Hibernate
      ...
      这些高级框架底层实现原理: 都采用了反射机制. 所以反射机制还是重要的.
      学会了反射机制有利于理解剖析底层的源代码.
  */
  public class ReflectTest03 {
      public static void main(String[] args) throws Exception {
          
          //这种方式就写死了. 只能创建一个User类型的对象
          //User user = new User();
          
          //以下代码是灵活的, 代码不需要改动, 可以修改配置文件, 配置文件修改后, 可以创建出不同的实例对象.
          //通过IO流读取classinfo.properties文件, 该文件是属性配置文件.
          FileRader reader = new FileReader("chapter/25/classinfo.properties");
          //创建属性类对象Map
          Properties pro = new Properties(); //key value都是String
          //加载
          pro.load(reader);
          //关闭流
          reader.close();
          
          //通过key获取value
          String className = pro.getProperty("className");
          System.out.println(className);
          
          //通过反射机制实例化对象
          Class c = Class.forName(className);
          Object obj = c.newInstance();
          System.out.println(obj);
      }
  }
  ```

* **[只让静态代码块执行可以使用forName]()** :

  ```java
  /*
  研究一下: Class.forName()发生了什么?
      记住, 重点:
          如果你只是希望一个类的静态代码块执行, 其他代码一律不执行.
          你可以使用: Class.forName("完整类名");
          这个方法的执行会导致类加载, 类加载时静态代码块执行.
  */
  public class ReflectTest04 {
      public static void main(String[] args) {
          try {
              //Class.forName()这个方法的执行会导致: 类加载.
              Class.forName("com.bjpowernode.java.reflect.MyClass");
          } catch (ClassNotFoundException e) {
              e.printStackTrace();
          }
      }
  }
  
  class MyClass {
      
      //静态代码块在类加载时执行, 并且只执行一次.
      static {
          System.out.println("MyClass类的静态代码块执行了!");
      }
  }
  ```

* **[获取类路径下的文件的绝对路径]()** : 

  ```java
  /*
  研究一下文件路径的问题.
  怎么获取一个文件的绝对路径. 以下讲解的这种方式是通用的. 但前提是: 文件需要在类路径下才能用这种方式.
  */
  public class AboutPath {
      public static void main(String[] args) throws Exception {
          //这种方式的路径缺点是: 移植性差. 在IDEA中默认的当前路径是project的根.
          //这个代码假设离开了IDEA, 换到了其他位置, 可能当前路径就不是project的根了, 这时这个路径就无效了.
          //FileRader reader = new FileReader("chapter/25/classinfo.properties");
          
          //接下来说一种比较通用的一种路径. 即使代码换位置了. 这样编写仍然是通用的.
          //注意: 使用以下通用方式的前提是: 这个文件必须在类路径下.
          //什么类路径下? 放在src下的都是类路径下. [记住它]
          //src是类的根路径.
          /*
          解释: 
              Thread.currentThread() : 当前线程对象
              getContextClassLoader() : 是线程对象的方法, 可以获取到当前线程的类加载器对象.
              getResource() : [释放资源]这是类加载器对象的方法, 当前线程的类加载器默认从类的根路径下加载资源.
          */
          //这行代码是通用的, 背下来. 
          //不过有一个前提, 你要获取的资源是在类的根路径下, 也就是src下.
          //这种方式适合于各种操作系统, 各种环境的.
          String path = Thread.currentThread().getContextClassLoader()
              .getResource("classinfo.properties(默认从类的根路径下作为起点)")
              .getPath();
          //采用以上的代码可以拿到一个文件的绝对路径.
          System.out.println(path);
      }
  }
  ```

* **[以流的形式直接返回]()** :

  ```java
  public class IoPropertiesTest {
      public static void main(String[] args) throws Exception {
          
          //String path = Thread.currentThread().getContextClassLoader()
          //    .getResource("classinfo.properties(默认从类的根路径下作为起点)")
          //    .getPath();
          //FileRader reader = new FileReader(path);
          
          //直接以流的形式返回, 等价于上面两行代码
          InputStream in = Thread.currentThread().getContextClassLoader()
              .getResourceAsStream("classinfo.properties");
          
          //创建属性类对象Map
          Properties pro = new Properties(); //key value都是String
          //加载
          pro.load(in);
          //关闭流
          reader.close();
          //通过key获取value
          String className = pro.getProperty("className");
          System.out.println(className);
      }
  }
  ```

* **[资源绑定器]()** :

  ```java
  /*
  java.util包下提供了一个资源绑定器, 便于获取属性配置文件中的内容.
  使用以下这种方式的时候, 属性配置文件xxx.properties必须放到类路径下.
  */
  public class ResourceBundleTest {
      public static void main(String[] args) {
          //资源绑定器, 只能绑定xxx.properties文件. 并且这个文件必须在类路径下. 文件扩展名也必须是properties
          //并且在路径的时候, 路径后面的扩展名不能写
          ResourceBundle bundle = ResourceBundle.getBundle("class.info2");
          
          String className = bundle.getString("className");
          System.out.println(className);
      }
  }
  ```

* **[类加载器概述]()** :

  1. 什么是类加载器?
     * 专门加载类的命令/工具.
     * ClassLoader.
  2. JDK中自带了3个类加载器:
     1. 启动类加载器;
     2. 扩展类加载器;
     3. 应用类加载器.
  3. 假设有这样一段代码: `String s = "abc"`
     * 代码在开始执行之前, 会将所需要类全部加载到JVM中. 通过类加载器加载, 看到以上代码类加载器会找String.class文件, 找到就加载, 那么是怎么进行加载的呢?
     * 首先通过启动类加载器加载. 注意: 启动类加载器专门加载jdk/jre/lib/rt.jar. rt.jar中都是JDK最核心的类库.
     * 如果通过启动类加载器加载不到的时候, 会通过扩展类加载器加载. 注意: 扩展类加载器专门加载jdk/jre/lib/ext/*.jar.
     * 如果扩展类加载器没有加载到, 那么会通过应用类加载器加载. 注意: 应用类加载器专门加载classpath中的类(class文件).
  4. java中为了保证类加载器的安全, 使用了双亲委派机制:
     * 优先从启动类加载器中加载, 这个称为父, 父无法加载到, 再从扩展类加载器中加载, 这个称为母. 双亲委派. 如果都加载不到, 才会考虑从应用类加载器中加载. 直到加载到为止.

#### 4. 反射Field

* **[获取Field(不用掌握)]()** : 

  * 对于Field的获取, 一般要获取三个东西: 名字, 类型, 修饰符. 
  * 注意: 都是字符串表示.

  ```java
  //反射属性
  public class Student {
      //Field翻译为字段, 其实就是属性/成员
      //4个Field, 分别采用了不同的访问控制权限修饰符
      public int no; //Field对象
      private String name; //Field对象
      protected int age;
      boolean sex;
      public static final double MATH_PI = 3.1415926;
  }
  
  /*
  反射Student类当中所有的Field
  */
  public class ReflectTest05 {
      public static void main(String[] args) throws Exception{
          //获取整个类
          Class studentClass = Class.forName("com.bjpowernode.java.bean.Stduent");
          
          String className = studentClass.getName();
          System.out.println("完整类名:" + className);
          
          String simpleName = studentClass.getSimpleName();
          System.out.println("简类名:" + simpleName);
          
          //获取类中所有的public修饰的Field
          Field[] fields = studentClass.getFields();
          System.out.println(Fields.length); //测试数组中只有一个元素
          //取出这个Field
          Field f = fields[0];
          //取出这个Field它的名字
          String fieldname = f.getName();
          System.out.println(fieldname);
          
          //获取所有的Field
          Field[] fs = studentClass.getDeclaredFields();
          System.out.println(fs.length);  //4
          
          System.out.println("======================================");
          //遍历
          for(Field field : fs) {
              //获取属性的修饰符列表
              int i = field.getModifiers(); //返回的修饰符是一个数字, 每个数字是修饰符的代号!!!
              System.out.println(i);
              //可以将这个代号数字转换成字符串吗?
              String modifierString = Modifier.toString(i);
              System.out.println(modifierString);
              //获取属性的类型
              Class fieldType = field.getType();
              //String fName = fieldType.getName();
              String fName = fieldType.getSimpleName();
              System.out.println(fName);
              //获取属性的名字
              System.out.println(field.getName());
          }
      }
  }
  ```

* **[反编译Field(不用掌握)]()** :

  ```java
  //通过反射机制, 反编译一个类的属性Field
  public class ReflectTest06 {
      public static void main(String[] args) throws Exception {
          
          //创建这个是为了拼接字符串
          StringBuilder s = new StringBuilder();
          
          //Class studentClass = Class.forName("com.bjpowernode.java.bean.Student");
          //Class studentClass = Class.forName("java.util.Date");
          //Class studentClass = Class.forName("java.lang.String");
          Class studentClass = Class.forName("java.lang.Thread");
          
          s.append(Modifier.toString(studentClass.getModifiers()) + "class" + studentClass.getSimpleName() + " {\n");
          
          Field[] fields = studentClass.getDeclaredFields();
          for(Field field : fields) {
              s.append("\t");
              s.append(Modifier.toString(field.getModifiers()));
              s.append(" ");
              s.append(field.getType().getSimpleName());
              s.append(" ");
              s.append(field.getName());
              s.append(";\n");
              
          }
          
          s.append("}");
          System.out.println(s);
      }
  }
  ```

* **[通过反射机制访问对象属性(必须掌握)]()** :

  ```java
  /*
  怎么通过反射机制访问一个java对象的属性?
  	给属性赋值set
  	获取属性的值get
  */
  public class ReflectTest07 {
      public static void main(String[] args) throws Exception {
          //不使用反射机制, 怎么访问一个对象的属性?
          Student s = new Student();
          //给属性赋值
          s.no = 1111; //三要素: 给s对象的no赋值1111
                       //要素1: 对象s
                       //要素2: no属性
                       //要素3: 1111
          //读属性值
          //两个要素: 获取s对象的no属性的值
          System.out.println(s.no);
          
          //使用反射机制, 怎么去访问一个对象的属性. (set get)
          Class studentClass = Class.forName("com.bjpowernode.java.bean.Student");
          Object obj = studentClass.newInstance(); //obj就是Student对象. (底层调用无参数构造方法)
          //获取no属性(根据属性的名称来获取Field)
          Field noField = studentClass.getDeclaredField("no");
          
          //给obj对象(Student对象)的no属性赋值
          /*
          虽然使用了反射机制, 但是三要素还是缺一不可:
          	要素1: obj对象
          	要素2: no属性
          	要素3: 22222值
          注意: 反射机制让代码复杂了, 但是为了一个灵活, 这也是值得的.
          */
          noField.set(obj, 22222); //给obj对象的no属性赋值22222
          
          //读取属性的值
          //两个要素: 获取obj对象的no属性的的值
          System.out.println(noField.get(obj));
          
          //可以访问私有的属性吗? 不可以. 要想访问, 要打破封装.
          Field nameField = studentClass.getDeclaredField("name");
          
          //打破封装(反射机制的缺点: 打破封装, 可能会给不法分子留下机会!!!)
          //这样设置完之后, 在外部也是可以访问private的.
          nameField.setAccessible(true);
          
          //给name属性赋值
          nameField.set(obj, "jackson");
          //获取name属性的值
          System.out.println(nameField.get(obj));
      }
  }
  ```

* **[可变长度参数]()** :

  ```java
  /*
  可变长度参数
  	int... args 这就是可变长度参数.
  	语法是: 类型... (注意: 一定是三个点.)
  	
  	1. 可变长度参数要求的参数个数是: 0-N个.
  	2. 可变长度参数在参数列表中必须在最后一个位置上. 而且可变长度参数只能有一个.
  	3. 可变长度参数可以当做一个数组来看待.
  */
  public class ArgsTest {
      public static void main(String[] args) {
          m();
          m(10);
          m(10, 20);
          
          m2(100);
          m2(200, "abc");
          m2(200, "abc", "def");
          m2(200, "abc", "def", "xyz");
          
          m3("ab", "de", "kk", "ff");
          String[] strs = {"a", "b", "c"};
          //也可以传一个数组
          m3(strs);
          
          //直接传一个数组
          m3(new String[]{"我", "是", "中", "国", "人"}); //没必要
          
      }
      
      public static void m(int... args) {
          System.out.println("m方法执行了!");
      }
      
      //必须在最后, 只能有一个.
      public static void m2(int a, String... arg1) {
          
      }
      
      public static void m3(String... args) {
          //args有length属性, 说明args是一个数组!
          //可以将可变长度参数当做一个数组来看.
          for(int i = 0; i < args.length; i++) {
              System.out.println(args[i]);
          }
      }
  }
  ```


#### 5. 反射Method

* **[反射Method]()** :

  ```java
  /**
   * 用户业务类
   */
  public class UserService {
      
      /**
       * 登录方法
       * @param name 用户名
       * @param password 密码
       * @return true表示登录成功, false表示登录失败!
       */
      public boolean login(String name, String password) {
          if("admin".equals(name) && "123".equals(password)) {
              return true;
          }
          return false;
      }
      
      public void logout() {
          System.out.println("系统已经安全退出!");
      }
  }
  ```

  ```java
  /*
  作为了解内容(不需要掌握):
  	反射Method
  */
  public class ReflectTest08 {
      public static void main(String[] args) throws Exception {
          
          //获取类
          Class userServiceClass = Class.forName("com.bjpowerNode.java.service.UserService");
          //获取所有的Method(包括私有的!)
          Method[] methods = userServiceClass.getDeclaredMethods();
          //System.out.println(methods.length); //2
          
          //遍历Method
          for(Method method : methods) {
              //获取修饰符列表
              System.out.println(Modifier.toString(method.getModifiers()));
              //获取方法的返回值类型
              System.out.println(method.getReturnType().getSimpleName());
              //获取方法名
              System.out.println(method.getName);
              //方法的参数列表(一个方法的参数可能会有多个.)
              Class[] parameterTypes = method.getParameterTypes();
              for(Class parameterType : parameterTypes) {
                  System.out.println(parameterType.getSimpleName());
              }
          }
      }
  }
  ```

* **[反编译Method]()** : 

  ```java
  /*
  了解一下, 不需要掌握
  */
  public class ReflectTest09 {
      public static void main(String[] args) {
          StringBuilder s = new StringBuilder();
          Class userServiceClass = Class.forName("com.bjpowernode.java.service.UserService");
          s.append(Modifier.toString(userServiceClass.getModifiers()) + "class " + userServiceClass.getSimpleName() + "{");
          
          Method[] methods = userServiceClass.getDeclaredMethods();
          for(Method method : methods) {
              s.append("\t");
              s.append(Modifier.toString(method.getModifiers()));
              s.append(" ");
              s.append(method.getName());
              s.append("(");
              //参数列表
              Class[] parameterTypes = method.getParameterTypes();
              for(Class parameterType : parameterTypes) {
                  s.append(parameterType.getSimpleName());
                  s.append(",");
              }
              //删除指定下标位置上的字符
              //s.deleteCharAt(s.length() - 1);
              s.substring(0, s.length());
              s.append("){}\n");
          }
          
          s.append("}");
          System.out.println(s);
              
      }
  }
  ```

* **[反射机制调用方法]()** :

  ```java
  /*
  重点: 必须掌握, 通过反射机制怎么调用一个对象的方法?
       五颗星*****
       
       反射机制, 让代码很具有通用性, 可变化的内容都是写到配置文件当中, 将来修改配置文件之后, 创建的对象不一样了, 调用的方法也不同了, 但是java代码不需要做任何改动. 这就是反射机制的魅力.
  */
  public class ReflectTest10 {
      public static void main(String[] args) {
          //不使用反射机制, 怎么调用方法
          //创建对象
          UserService userService = new UserService();
          //调用方法
          /*
           要素分析:
           	要素1: 对象userService
           	要素2: login方法名
           	要素3: 实参列表
           	要素4: 返回值
          */
          boolean loginSuccess = userService.login("admin", "123");
          System.out.println(loginSuccess);
          System.out.println(loginSuccess ? "登录成功" : "登录失败");
          
          //使用反射机制来调用一个对象的方法该怎么做?
          //java中怎么区分一个方法, 依靠方法名和参数列表
          Class userServiceClass = Class.forName("com.bjpowernode.java.service.UserService");
          //创建对象
          Object obj = userServiceClass.newInstance();
          //获取Method
          Method loginMethod = userServiceClass.getDeclareMethod("login", String.class, String.class);
          Method loginMethod = userServiceClass.getDeclareMethod("login", int.class);
          //调用方法
          //调用方法有几个要素? 也需要4要素
          //invoke()是反射机制中最最最最最重要的一个方法, 必须记住.
          //四要素:
          /*
           loginMethod 方法
           obj 对象
           "admin", "123" 实参
           retValue 返回值
          */
          Object retValue = loginMethod.invoke(obj, "admin", "123");
          System.out.println(retValue);
      }
  }
  ```

#### 6. 反射Constructor

* **[反编译Constructor]()** : 

  ```java
  public class Vip {
      int no;
      String name;
      String birth;
      boolean sex;
      
      public Vip() {
          
      }
      
      public Vip(int no) {
          this.no = no;
      }
      
      public String toString() {
          
      }
  }
  ```

  ```java
  /*
  反编译一个类的Constructor构造方法
  */
  public class ReflectTest11 {
      public static void main(String[] args) throws Exception {
          StringBulider s = new StringBuilder();
          Class vipClass = Class.forName("com.bjpowernode.java.bean.Vip");
          s.append(Modifier.toString(vipClass.getModifiers()));
          s.append(" class ");
          s.append(vipClass.getSimpleName());
          s.append("{\n");
          
          //拼接构造方法
          Constructor[] constructors = vipClass.getDeclaredConstructors();
          for(Constructor constructor : constructors) {
              s.append("\t");
              s.append(Modifier.toString(constructor.getModifiers()));
              s.append(" ");
              s.append(vipClass.getSimpleName());
              s.append("(");
              //拼接参数
              Class[] parameterTypes = constructor.getParameterTypes();
              for(Class parameterType : parameterTypes) {
                  s.append(parameterType.getSimpleName());
                  s.append(",");
              }
              
              if(parameterTypes.length > 0) {
                  //删除指定下标位置上的字符
                  //s.deleteCharAt(s.length() - 1);
                  s.substring(0, s.length());
              }
              s.append("){}\n");
          }
          
          s.append("}");
          System.out.println(s);
      }
  }
  ```

* **[反射机制调用构造方法]()** :

  ```java
   /*
   比上一个例子重要一些!!!
   
   通过反射机制调用构造方法实例化java对象(这个不是重点).
   */
  public class ReflectTest12 {
      public static void main(String[] args) throws Exception {
          //不使用反射机制怎么创建对象
          Vip v1 = new Vip();
          Vip v2 = new Vip(110, "张三", "2001-10-11", true);
          
          //使用反射机制怎么创建对象呢?
          Class c = Class.forName("com.bjpowernode.java.bean.Vip");
          //调用无参数构造方法
          Object obj = c.newInstance();
          System.out.println(obj);
          //调用有参数的构造方法怎么办?
          //当然也可以通过以下方式调用无参数构造方法
          //第一步: 先获取到这个有参数的构造方法
          Constructor con = c.getDeclaredContructor(int.class, String.class, String.class, boolean.class);
          //第二步: 调用构造方法new对象
          Object newobj = con.newInstance(110, "张三", "2001-10-11", true);
          System.out.println(newobj);
      }
  }
  ```

* **[获取父类和父接口]()** :

  ```java
  /*
  重点: 给一个类, 怎么获取这个类的父类, 已经实现了哪些接口?
  */
  public class ReflectTest13 {
      public static void main(String[] args) throws Exception {
          
          //String举例
          Class stringClass = Class.forName("java.lang.String");
          
          //获取String的父类
          Class superClass = stringClass.getSuperClass();
          System.out.println(superClass.getName());
          
          //获取String类实现的所有接口(一个类可以实现多个接口)
          Class[] interfaces = stringClass.getInterfaces();
          for(Class in : interfaces) {
              System.out.println(in.getName());
          }
      }
  }
  ```
