#### 第一章 spring课程四天安排

* 第一天：spring框架的概述以及spring中基于XML的IOC配置
* 第二天：spring中基于注解的IOC和IOC的案例
* 第三天：spring中的AOP和基于XML以及注解的AOP配置
* 第四天：spring中的JDBCTemplate以及Spring事务控制

#### 第二章 spring第一天课程

* 第一天课程内容介绍：
    1. **spring的概述：**
        * spring是什么
        * spring的两大核心
        * spring的发展历程和优势
        * spring的体系结构
    2. **程序的耦合和解耦：**
        * 曾经案例中问题
        * 工厂模式解耦
    3. **IOC概念和spring中的IOC：**
        * spring中基于XML的IOC环境搭建
    4. **依赖注入（dependency injection）**

* spring概述：
    1. **spring是什么：**
        * spring是分层的javaSE/EE应用***full-stack***轻量级开源框架，<u>以IOC（inverse of control：反转控制）和AOP（aspect oriented programming：面向切面编程）为内核</u>，提供了展现层springmvc和持久层springjdbc以及业务层事务管理等众多的企业级应用技术，还能整合开源世界众多著名的第三方框架和类库，逐渐成为使用最多的javaee企业应用开源框架。
        * ![](D:\ssm框架-figure\1.png)
    2. **spring的优势：**
        1. ***方便解耦，简化开发：***通过spring提供的IOC容器，可以将对象间的依赖关系交由spring进行控制，避免硬编码所造成的过度程序耦合。用户也不必再为单例模式类，属性文件解析等这些很底层的需求编写代码，可以更专注于上层的应用。
        2. ***AOP编程的支持：***通过spring的AOP功能，方便进行面向切面编程，许多不容易用传统OOP实现的功能可以通过AOP轻松应付。
        3. ***声明式事务的支持：***可以将我们从单调烦闷的事务管理代码中解脱出来，通过声明式方式灵活的进行事务的管理，提高开发效率和质量。
        4. ***方便程序的测试：***可以非容器依赖的编程方式进行几乎所有的测试工作，测试不再是昂贵的操作，而是随手可做的事情。
        5. ***方便集成各种优秀框架：***spring可以降低各种框架的使用难度，提供了对各种优秀框架的直接支持。
        6. ***降低javaEEAPI的使用难度：***spring对javaeeAPI（如jdbc，javamail，远程调用等）进行了薄薄的封装层，使这些API的使用难度大为降低。
        7. ***java源码是经典学习范例：***spring的源代码设计精妙，结构清晰，匠心独用，处处体现着大师对java设计模式灵活运用以及对java技术的高深造诣。它的源代码无意是java技术的最佳实践的范例。
    3. **spring的体系结构：**
        * 注意：在课程的开发过程中，全都是基于maven工程去构建项目的。
        * ![](D:\学习资料\SSM框架\mybatis-spring-springmvc-oracle-maven高级-权限管理\02-Spring\01-第一天\资料\spring-framework-5.0.2.RELEASE-dist\spring-framework-5.0.2.RELEASE\docs\spring-framework-reference\images\spring-overview.png)
* 程序的耦合和解耦：
    1. **编写JDBC的工程代码用户分析程序的耦合：**
        