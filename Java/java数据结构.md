## 数据结构和算法内容介绍

#### 1. 几个经典的算法面试题

1. 字符串匹配问题: 
   1. 暴力匹配; (简单, 效率低)
   2. KMP算法. (建立一个部分匹配表)
2. 汉诺塔游戏:
   1.  分治算法.
3. 八皇后问题: 
   * 问题说明: 在8*8格的国际象棋上摆放八个皇后, 使其不能互相攻击, 即任意两个皇后都不能处于同一行, 同一列或同一斜线上, 问题有多少种摆法.(92种)
   * 解决方法: 回溯算法.
4. 马踏棋盘算法:
   * 问题说明: 将吗随机放在国际象棋的8*8棋盘的某个方格中, 马按走棋规则进行移动. 要求每个方格只进入一次, 走遍棋盘上全部64个方格.
   * 解决方法: 图的深度优先遍历算法(DFS)+贪心算法优化.

#### 2. 内容介绍

1. 数据结构和算法的介绍
2. 稀疏数组和队列
3. 链表
4. 栈
5. 递归
6. 排序算法
7. 查找算法
8. 哈希表
9. 树结构的基础部分
10. 树结构实际应用
11. 多路查找树
12. 图
13. 程序员常用10大算法:
    1. 二分查找算法(非递归)
    2. 分治算法
    3. 动态规划算法
    4. KMP算法
    5. 贪心算法
    6. 普利姆算法
    7. 克鲁斯卡尔算法
    8. 迪杰斯特拉算法
    9. 弗洛伊德算法
    10. 马踏棋盘算法

#### 3. 数据结构和算法概述

* 数据结构是一门研究组织数据方式的学科.
* 程序 = 数据结构+算法 (数据结构是算法的基础).
* 要学习好数据结构就要多多考虑如何将生活中遇到的问题用程序去实现解决.

#### 4. 编程中实际遇到的几个问题

1.  写出单链表表示的字符串类以及字符串节点类的定义, 并以此实现它的构造函数, 以及计算串长度, 串赋值, 判断两串是否相等, 求子串, 两串连接, 求子串在串中位置等7个成员函数.
2. 一个五子棋程序. 
   * 棋盘 -> 二维数组(稀疏数组) -> 写入文件 (存档功能)
   * 读取文件 -> 稀疏数组 -> 二维数组 -> 棋盘 (接上局)
3. 约瑟夫问题(丢手帕问题): 单向环形链表.
4. 修路问题: 最小生成树(普利姆算法).
5. 最短路径问题: 弗洛伊德算法.
6. 汉诺塔: 分治算法.
7. 八皇后问题: 回溯算法.

#### 5. 数据结构包括哪些内容

数据结构包括: **线性结构和非线性结构**.

1. [线性结构]():
   1. 特点: 数据元素之间存在`一对一的线性关系`;
   2. 分类: `线性结构有两种不同的存储结构`, 即**顺序存储结构和链式存储结构**. 顺序存储的线性表称为顺序表, 顺序表中的存储元素是连续的; 链式存储的线性表称为链表, 链表中的存储元素不一定是连续的, 元素节点中存放数据元素以及相邻元素的地址信息.
   3. 线性结构常见的有: 数组, 队列, 链表和栈.
2. [非线性结构]():
   * 非线性结构包括: 二维数组, 多维数组, 广义表, `树结构`, `图结构`.



## 稀疏数组和队列

#### 1. 稀疏数组的应用场景

* [实际需求]() : 编写的五子棋程序中, 有存盘退出和续上盘的功能. 可以使用二维数组记录棋盘. 因为该二维数组的很多只都是默认值0, 因此记录了很多没有意义的数据, 所以应该用稀疏数组对二维数组进行压缩.

* [稀疏数组的基本介绍]() : 当一个数组中大部分元素为0, 或者为同一个值的数组时, 可以使用稀疏数组来保存该数组. 

  ![](D:\java数据结构-figure\1.png)

* [稀疏数组的处理方法]() : 

  1. 记录数组一共有几行几列, 有多少个不同的值;
  2. 把具有不同值的元素的行列及值记录在一个小规模的数组中, 从而缩小程序的规模.

#### 2. 稀疏数组转换思路分析

* [二维数组转稀疏数组的思路]() : 
  1. 遍历原始二维数组, 得到有效数据的个数sum;
  2. 根据sum就可以创建稀疏数组`sparseArr = int[sum+1][3]`;
  3. 将二维数组的有效数据存入到稀疏数组.
* **[稀疏数组转原始的二维数组的思路]()** : 
  1. 先读取稀疏数组的第一行, 根据第一行的数据, 创建原始的二维数组, 比如上面的`chessArr2 = int[11][11]`;
  2. 再读取稀疏数组后几行的数据, 并赋给原始的二维数组即可.

#### 3. 稀疏数组的代码实现

```java
public class SparseArray {
    
    public static void main(String[] args) {
        //创建一个原始的二维数组11*11
        //0:表示没有棋子, 1表示黑子, 2表示蓝子
        int chessArr1[][] = new int[11][11];
        chessArr1[1][2] = 1;
        chessArr1[2][3] = 2;
        //输出原始的二维数组
        System.out.println("原始的二维数组~~");
        for(int[] row : chessArr1) {
            for(int data : row) {
                System.out.printf("%d\t", data);
            }
            System.out.println();
        }
        
        //将二维数组转为稀疏数组
        //1.先遍历二维数组得到非0数据的个数
        int sum = 0;
        for(int i = 0; i < 11; i++) {
            for(int j = 1; j < 11; j++) {
                sum++;
            }
        }
        
        //2.创建对应的稀疏数组
        int sparseArr[][] = new int[sum + 1][3];
        //给稀疏数组赋值
        sparseArr[0][0] = 11;
        sparseArr[0][1] = 11;
        sparseArr[0][2] = sum;
        //遍历二维数组, 将非0的值存放到sparseArr中
        int count = 0; //count哟怒记录是第几个非0数据
        for(int i = 0; i < 11; i++) {
            for(int j = 0; j < 11; j++) {
                if(chessArr1[i][j] != 0) {
                    counnt++;
                    sparseArr[count][0] = i;
                    sparseArr[count][1] = j;
                    sparseArr[count][2] = chessArr[i][j];
                }
            }
        }
        
        //输出稀疏数组的形式
        System.out.println();
        System.out.println("得到的稀疏数组为~~~~");
        for(int i = 0; i < sparseArr.length; i++) {
            System.out.printf("%d\t%d\t%d\t\n", sparseArr[i][0], sparseArr[i][1], sparseArr[i][2]);
        }
        System.out.println();
        
        //将稀疏数组 -->> 恢复成原始的二维数组
        //1. 先读取稀疏数组的第一行, 根据第一行的数据, 创建原始的二维数组, 比如上面的chessArr2  = int[11][11]
        int chessArr2 = new int[sparseArr[0][0]][sparseArr[0][1]];
        
        //2. 再读取稀疏数组后几行的数据(从第二行开始), 并赋给原始的二维数组即可.
        for(int i = 1; i < sparseArr; i++) {
            chessArr2[sparseArr[i][0]][sparseArr[i][1]] = sparseArr[i][2];
        }
        
        //输出恢复后的二维数组
        System.out.println();
        System.out.println("恢复后的二维数组");
        
        for(int[] row : chessArr2) {
            for(int data : row) {
                System.out.printf("%d\t", data);
            }
            System.out.println();
        }
    }
}
```

#### 4. 队列的应用场景和介绍

* **[使用场景]()** : 银行排队的案例.
* **[队列介绍]()** : 
  * 队列是一个有序列表, 可以用**数组或是链表**来实现.
  * 遵循先入先出的原则. 即: 先存入队列的数据, 要先取出. 后存入的要后取出.

#### 5. 数组模拟队列的思路分析

* **[队列属性的思路分析]()** : 队列本身是有序列表, 若使用数组的结构来存储队列的数据, 则队列数组的声明中除了一个**数组**, 还要有一个maxSize, **maxSize是该队列的最大容量**. 因为队列的输出, 输入是分别从前后端来处理, 因此需要**两个变量front及rear分别记录队列前后端的下标**. front会随着数据输出而改变, rear则是随着数据输入而改变.
* **[队列方法的思路分析]()** : 将数据存入队列时称为`addQueue`. addQueue的处理需要两个步骤.
  1. 将尾指针后移: `rear+1`, 当`front==rear`时, **队列为空**;
  2. 若尾指针rear小于队列的最大下标maxSize-1, 则将数据存入rear所指的数据元素中, 否则无法存入数据. `rear==maxSize-1`, 则**队列满**.

#### 6. 数组模拟队列的代码实现

1. 数组模拟队列:

```java
public class ArrayQueueDemo {
    
    public static void main(String[] args) {
        //测试一把
        //创建一个队列
        ArrayQueue queue = new ArrayQueue(3);
        char key = ' '; //接收用户输入
        Scanner scanner = new Scanner(System.in);
        boolean loop = true;
        //输出一个菜单
        while(loop) {
            System.out.println("s(show): 显示队列");
            System.out.println("e(exit): 退出程序");
            System.out.println("a(add): 添加数据到队列");
            System.out.println("g(get): 从队列取出数据");
            System.out.println("h(head): 查看队列头元素");
            key = sanner.next().charAt(0); //接收一个字符
            switch(key) {
                case 's' :
                    queue.showQueue();
                    break;
                case 'a' :
                    System.out.println("输出一个数");
                    int value = scanner.nextInt();
                    arrayQueue.addQueue(value);
                    break;
                case 'g' : //取出数据
                    try {
                        int res = queue.getQueue();
                        System.out.printf("取出的数据是%d\n", res);
                    } catch(Exception e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'h' : //查看队列头的数据
                    try {
                        int res =queue.headQueue();
                        System.out.printf("队列头的数据是%d\n", res);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'e' : //退出
                    scanner.close();
                    loop = false;
                    break;
                default:
                    break;
            }
        }
        System.out.println("程序退出~~");
    }
}

//使用数组模拟队列-编写一个ArrayQueue类
class ArrayQueue {
    private int maxSize; //表示数组的最大容量
    private int front; //队列头
    private int rear; //队列尾
    private int[] arr; //该数组用于存放数据, 模拟队列
    
    //创建队列的构造器
    public ArrayQueue(int arrMaxSize) {
        maxSize = arrMaxSize;
        arr = new int[maxSize];
        front = -1; //指向队列头部, 分析出front是指向队列头的前一个位置
        rear = -1; //指向队列尾, 指向队列尾的数据(即就是队列最后一个数据)
    }
    
    //判断队列是否满
    public boolean isFull() {
        return rear == maxSize - 1;
    }
    
    //判断队列是否为空
    public boolean isEmpty() {
        return rear == front;
    }
    
    //添加数据到队列
    public void addQueue(int n) {
        //判断队列是否满
        if(isFull()) {
            System.out.println("队列满, 不能加入数据~");
            return;
        }
        rear++; //让rear后移
        arr[rear] = n;
    }
    
    //获取队列的数据, 出队列
    public int getQueue() {
        //判断队列是否空
        if(isEmpty()) {
            // 通过抛出异常
            throw new RuntimeException("队列空, 不能取数据");
        }
        front++; //front后移
        return arr[front];
    }
    
    //显示队列的所有数据
    public void showQueue() {
        //遍历
        if(isEmpty()) {
            System.out.println("队列空的, 没有数据~");
            return;
        }
        for(int i = 0; i < arr.length; i++) {
            System.out.printf("arr[%d]=%d\n", i, arr[i]);
        }
    }
    
    //显示队列的头数据, 注意不是取数据
    public int headQueue() {
        //判断
        if(isEmpty()) {
            throw new RuntimeException("队列是空的, 没有数据~");
        }
        return arr[front + 1];
    }
}
```

2. 上述数组模拟队列有缺点, 该队列只能使用一次, 没有达到复用的效果, 所以要对其进行优化, 变为环形队列, 通过取模(%)的方式实现.

#### 7. 数组模拟环形队列思路分析图

* **[思路如下]()**:

  1. front变量的含义做一个调整: **front就指向队列的第一个元素**, 也就是说arr[front]就是队列的第一个元素, **front的初始值=0**;
  2. rear变量的含义做一个调整: **rear指向队列的最后一个元素的后一个位置**. 因为希望**空出一个空间作为约定**, **rear的初始值=0**;
  3. 当队列满时, 条件是 `(rear + 1) % maxSize = front ` (满)
  4. 当队列为空时, 条件是 `rear == front` (空)
  5. **(重点)**队列中有效的数据的个数: `(rear + maxSize - front) % maxSize` 

* **[思路分析图]()** :

  ![](D:\java数据结构-figure\2.png)

#### 8. 数组模拟环形队列代码实现
```java
public class CircleArrayQueueDemo {
    
    public static void main(String[] args) {
        //测试一把
        System.out.println("测试数组模拟环形队列的案例~~");
        //创建一个队列
        CircleArray queue = new CircleArray(4); //说明: 设置的4, 其队列的有效数据的最大是3
        char key = ' '; //接收用户输入
        Scanner scanner = new Scanner(System.in);
        boolean loop = true;
        //输出一个菜单
        while(loop) {
            System.out.println("s(show): 显示队列");
            System.out.println("e(exit): 退出程序");
            System.out.println("a(add): 添加数据到队列");
            System.out.println("g(get): 从队列取出数据");
            System.out.println("h(head): 查看队列头元素");
            key = sanner.next().charAt(0); //接收一个字符
            switch(key) {
                case 's' :
                    queue.showQueue();
                    break;
                case 'a' :
                    System.out.println("输出一个数");
                    int value = scanner.nextInt();
                    arrayQueue.addQueue(value);
                    break;
                case 'g' : //取出数据
                    try {
                        int res = queue.getQueue();
                        System.out.printf("取出的数据是%d\n", res);
                    } catch(Exception e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'h' : //查看队列头的数据
                    try {
                        int res =queue.headQueue();
                        System.out.printf("队列头的数据是%d\n", res);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'e' : //退出
                    scanner.close();
                    loop = false;
                    break;
                default:
                    break;
            }
        }
        System.out.println("程序退出~~");
    }
}

class CircleArray {
    private int maxSize; //表示数组的最大容量
    //front变量的含义做一个调整: front就指向队列的第一个元素, 也就是说arr[front]就是队列的第一个元素
    //front的初始值=0
    private int front; //队列头
    //rear变量的含义做一个调整: rear指向队列的最后一个元素的后一个位置.因为希望空出一个空间作为约定
    //rear的初始值=0
    private int rear; //队列尾
    private int[] arr; //该数组用于存放数据, 模拟队列
    
    public CircleAarray(int arrMaxSize) {
        maxSize = arrMaxSize;
        arr = new int[maxSize];
        rear = front = 0; //可以不写, int类型的变量自动初始化为0
    }
    
    //判断队列是否满
    public boolean isFull() {
        return (rear + 1) % maxSize == front;
    }
    
    //判断队列是否空
    public boolean isEmpty() {
        return rear == front;
    }
    
    //添加数据到队列
    public void addQueue(int n) {
        //判断队列是否满
        if(isFull()) {
            System.out.println("队列满, 不能加入数据~");
            return;
        }
        //直接将数据加入
        arr[rear] = n;
        //将rear后移, 这里必须考虑取模
        rear = (rear + 1) % maxSize;
    }
    
    //获取队列的数据, 出队列
    public int getQueue() {
        //判断队列是否为空
        if(isEmpty()) {
            throw new RuntimeException("队列空, 不能取数据"); //注意:遇到异常, 程序停止, 所以不需要再加return;
        }
        //这里需要分析出front是指向队列的第一个元素
        //1.先把front对应的值保留到一个临时变量
        //2.将front后移, 考虑取模
        //3.将临时变量保存的变量返回
        int value = arr[front];
        front = (front + 1) % maxSize;
        return value;
    }
    
    //显示队列的所有数据
    public void showQueue() {
        //遍历
        if(isEmpty()) {
            System.out.println("队列空的, 没有数据~~");
            return;
        }
        //思路: 从front开始遍历, 遍历多少个元素  
        for(int i = front; i < front + size(); i++) {
            System.out.printf("arr[%d]=%d\n", i % maxSize, arr[i % maxSize]);
        }
    }
    
    //求出当前队列有效数据的个数
    public int size() {
        return (rear + maxSize - front) % maxSize;
    }
    
    //显示队列的头数据, 注意不是取出数据
    public int headQueue() {
        //判断
        if(isEmpty()) {
            throw new RuntimeException("队列空的, 没有数据~~");
        }
        return arr[front];
    }
    
}
```



## 链表

#### 1. 单链表介绍和内存布局

* 链表是以节点的方式来存储.
* 每个节点包含data域, next域: 指向下一个节点.
* **链表的各个节点不一定是连续存储的**.
* 链表分**带头节点的链表**和**没有头节点的链表**, 根据实际的需求来确定.

#### 2. 单链表创建和遍历的分析实现

* **[单链表的应用实例]()** :

  ![](D:\java数据结构-figure\3.png)

* **[单链表的创建示意图(添加), 显示单向链表分析]()** : 

  ![](D:\java数据结构-figure\4.png)

  * **head节点** :
    1. 不存放具体的数据;
    2. 作用就是表示单链表头.
  * **添加(创建)** : 
    1. 先创建一个head头结点, 作用就是表示单链表的头;
    2. 后面每添加一个节点, 就直接加入到链表的最后.
  * **遍历** : 
    1. 通过一个辅助变量遍历, 帮助遍历整个链表. 遍历时头节点不能动, 如果动了, 就找不到这个链表了.其实这个头结点就标识整个单链表.

* **[应用实例的第一种方法的代码实现]()** : 
```java
  public class SingleLinkedListDemo {
      
      public static void main(String[] args) {
          //进行测试
          //先创建节点
          HeroNode hero1 = new HeroNode(1, "宋江", "及时雨");
          HeroNode hero2 = new HeroNode(2, "卢俊义", "玉麒麟");
          HeroNode hero3 = new HeroNode(3, "吴用", "智多星");
          HeroNode hero4 = new HeroNode(4, "林冲", "豹子头");
          
          //创建单链表
          SingleLinkedList singleLinkedList = new SingleLinkedList();
          
          //加入
          singleLinkedList.add(hero1);
          singleLinkedList.add(hero2);
          singleLinkedList.add(hero3);
          singleLinkedList.add(hero4);
          
          //加入按照编号的顺序
          singleLinkedList.addByOrder(hero1);
          singleLinkedList.addByOrder(hero4);
          singleLinkedList.addByOrder(hero2);
          singleLinkedList.addByOrder(hero3);
          singleLinkedList.addByOrder(hero3);
          
          //显示一把
          singleLinkedList.list();
          
          //测试修改节点的代码
          HeroNode newHeroNode = new HeroNode(2, "小卢", "玉麒麟~~");
          singleLinkedList.update(newHeroNode);
          
          System.out.println("修改后的链表情况~~");
          singleLinkedList.list();
          
          //删除一个节点
          singleLinkedList.del(1);
          
          System.out.println("删除后的链表情况~~");
          singleLinkedList.list();
      }
  }
  
  //定义SingleLinkedList管理我们的英雄
  class SingleLinkedList {
      //先初始化一个头结点, 头结点不要动, 不存放具体的数据
      private HeroNode head = new HeroNode(0, "", "");
      
      //添加节点到单向链接
      //思路: 当不考虑编号顺序时
      //1.找到当前链表的最后节点
      //2.将最后这个节点的next指向新的节点
      public void add(HeroNode heroNode) {
          
          //因为head节点不能动, 因此需要一个辅助遍历temp
          HeroNode temp = head;
          //遍历链表, 找到最后
          while(true) {
              //找到链表的最后
              if(temp.next == null) {
                  break;
              }
              //如果没有找到最后, 将temp后移
              temp = temp.next;
          }
          //当退出while循环时, temp就指向了链表的最后
          //将最后这个节点的next指向新的节点
          temp.next = heroNode;
      }
      
      //显示链表(遍历)
      public void list() {
          //判断链表是否为空
          if(head.next == null) {
              System.out.println("链表为空");
              return;
          }
          //因为头结点, 不能动, 因此需要一个辅助变量来遍历
          HeroNode temp = head;
          while(true) {
              //判断是否到链表最后
              if(temp == null) {
                  break;
              }
              //输出节点的信息
              System.out.println(temp); //调用HeroNode的toString方法
              //将temp后移, 一定小心
              temp = temp.next;
          }
      }
      
  }
  
  //定义HeroNode, 每个HeroNode对象就是一个节点
  class HeroNode {
      public int no;
      public String name;
      public String nickname;
      public HeroNode next; //指向下一个节点
      
      //构造器
      public HeroNode(int no, String name, String nickname) {
          this.no = no;
          this.name = name;
          this.nickname = nickname;
      }
      
      //为了显示方便, 重写toString方法
      public String toString() {
          return "HeroNode [no=" + no + ", name=" + name + ", nickname=" + nickname + "]";
      }
  }
```


* **[应用实例的第二种方法的思路分析]()** : (需要按照编号的顺序添加)

  1. **首先找到新添加的节点的位置**, 是通过辅助变量(指针), 通过遍历来搞定;
  2. `新的节点.next = temp.next`;
  3. `temp.next = 新的节点`.

* **[应用实例的第二种方法的代码实现]()** : 

  * 直接在第一种方法的单链表类中添加一个方法: addByOrder.
```java
  //第二种方式在添加英雄时, 根据排名将英雄插入到指定位置
  //如果有这个排名, 则添加失败, 并给出提示
  public void addByOrder(HeroNode heroNode) {
      //因为头结点不能动, 因此仍然通过一个辅助指针(变量)来帮助找到添加的位置
      //因为单链表, 因为找的temp是位于添加位置的前一个节点, 否则插入不了
      HeroNode temp = head;
      boolean flag = false; //flag标志添加的编号是否存在, 默认为false
      while(true) {
          if(temp.next == null) { //说明temp已经在链表的最后
              break;
          }
          if(temp.next.no > heroNode.no) { //位置找到, 就在temp的后面插入
              break;
          } else if(temp.next.no == heroNode.no) { //说明希望添加的heroNode的编号已然存在
              
              flag = true; //说明编号存在
              break;
          }
          temp = temp.next; //后移
      }
      //判断flag的值
      if(flag) { //不能添加, 说明编号存在
          System.out.printf("准备插入的英雄的编号%d已经存在了, 不能加入\n", heroNode.no);
      }else {
          //插入到链表中, temp的后面
          heroNode.next = temp.next;
          temp.next = heroNode;
      }
      
  }
```


* **[单链表节点的修改]()** : 

  * 直接在第一种方法的单链表类中添加一个方法: update.

```java
  //修改节点的信息, 根据no编号来修改, 即no编号不能改.
  //说明
  //1. 根据newHeroNode的no来修改即可.
  public void update(HeroNode newHeroNode) {
      //判断是否空
      if(head.next == null) {
          System.out.println("链表为空~");
          return;
      }
      //找到需要修改的节点, 根据no编号
      //定义一个辅助变量
      HeroNode temp = head.next;
      boolean flag = false; //表示是否找到该节点
      while(true) {
          if(temp == null) {
              break; //已经遍历完列表了
          }
          if(temp.no == newHeroNode.no) {
              //找到了
              flag = true;
              break;
          }
          temp = temp.next;
      }
      //根据flag判断是否找到要修改的节点
      if(flag) {
          temp.name = newHeroNode.name;
          temp.nickname = newHeroNode.nickname;
      }else { //没有找到
          System.out.printf("没有找到编号%d的节点, 不能修改\n", newHeroNode.no);
      }
  }
```

* **[单链表节点的删除]()** : 

  * 从单链表中删除一个节点的思路 : 
    1. 先找到需要删除的这个节点的前一个节点temp;
    2. `temp.next = temp.next.next`;
    3. 被删除的节点, 将不会有其他引用指向, 会被垃圾回收机制回收.
  * 直接在第一种方法的单链表类中添加一个方法: del.

```java
  //删除节点
  //思路
  //1. head不能动, 因此需要一个temp辅助节点找到待删除节点的前一个节点
  //2. 在比较时, 是temp.next.no和需要删除的节点的no比较
  public void del(int no) {
      HeroNode temp = head; //保证可以删除第一个节点
      boolean flag = false; //标志是否找到待删除节点
      while(true) {
          if(temp.next == null) { //已经到链表的最后
              break;
          }
          if(temp.next.no = no) {
              //找到的待删除节点的前一个节点
              flag = true;
              break;
          }
          temp = temp.next;
      }
      //判断flag
      if(flag) { //找到
          //可以删除
          temp.next = temp.next.next;
      }else {
          System.out.println("要删除的%d节点不存在\n", no);
      }
  }
```

#### 3. 单链表面试题

1. **[求单链表中节点的个数]()** : 

   * 因为getLength方法是通用的, 所以getLength方法放在SingleLinkedListDemo类中, 并且声明为静态的.

```java
    //方法: 获取到单链表的节点的个数(如果是带头结点的链表, 需求不统计头结点)
   /**
    * 
    * @param head链表的头结点
    * @return 返回的就是有效节点的个数
    */
   public static int getLength(HeroNode head) {
       if(head.next == null) { //空链表(特殊情况)
           return 0;
       }
       int length = 0;
       //定义一个辅助变量, 这里没有统计头结点
       HeroNode cur = head.next;
       while(cur != null) {
           length++;
           cur = cur.next; //遍历
       }
       return length;
   }
```

   * 由于单链表头结点是私有的, 所以在SingleLinkedList类中添加一个getHead方法, 来获取head.

```java
   //返回头结点
   public HeroNode getHead() {
       return head;
   }
```

   * 在main方法中测试.

```java
   //测试一下求单链表中有效节点的个数
   System.out.println("有效的节点个数=" + getLength(singleLinkedList.getHead()));
```

   

2. **[查找单链表中的倒数第k个节点(新浪面试题)]()** : 

   * 因为findLastIndexNode方法是通用的, 所以findLastIndexNode方法放在SingleLinkedListDemo类中, 并且声明为静态的.

```java
   //思路
   //1. 编写一个方法, 接收head节点, 同时接收一个index
   //2. index表示的是倒数第index个节点
   //3. 先把链表从头到尾遍历, 得到链表的总的长度getLength
   //4. 得到size后, 从链表的第一个开始遍历(size-index)个, 就可以得到了
   //5. 如果找到了, 则返回该节点, 否则返回null
   public static HeroNode findLastIndexNode(HeroNode head, int index) {
       //判断如果链表为空, 返回null
       if(head.next == null) { //特殊情况
           return null; //没有找到
       }
       //第一个遍历得到链表的长度(接地那个数)
       int size = getLength(head);
       //第二次遍历size-index位置, 就是我们倒数的第k个节点
       //先做一个index的校验
       if(index <= 0 || index > size) { //边界控制
           return null;
       }
       //定义给辅助变量, for循环定位到倒数的index
       HeroNode cur = head.next;
       for(int i = 0; i < size - index; i++) {
           cur = cur.next;
       }
       return cur;
   }
```

   * 在main方法中测试.

```java
   //测试一下看看是否得到了倒数第k个节点
   HeroNode res = findLastIndexNode(singleListedList.getHead(), 1);
   System.out.println("res=" + res);
```

   

3. **[单链表的反转腾讯面试题]()** : 

   * 思路:
     1. 先定义一个节点reverseHead = new HeroNode();
     2. 从头到尾遍历原来的链表, 每遍历一个节点, 就将其取出, 并放在新的链表reverseHead的最前端;
     3. 原来的链表的head.next = reverseHead.next.
   * 因为reverseList方法是通用的, 所以reverseList方法放在SingleLinkedListDemo类中, 并且声明为静态的.

```java
   //将单链表反转
   public static void reverseist(HeroNode head) {
       //如果当前链表为空, 或者只有一个节点, 无需反转, 直接返回
       if(head.next == null || head.next.next == null) { //特殊情况
           return;
       }
       
       //定义一个辅助的指针(变量), 帮助遍历原来的链表
       HeroNode cur = head.next;
       HeroNode next = null; //指针指向当前节点[cur]的下一个节点
       HeroNode reverseHead = new HeroNode(0, "", ""); //遍历原来的链表, 每遍历一个节点, 就将其取出, 并放在新的链表reverseHead的最前端
       while(cur != null) {
       	next = cur.next; //先暂时保存当前节点的下一个节点, 因为后面需要使用    
           cur.next = reverseHead.next; //将cur的下一个节点指向新的链表的最前端
           reverseHead.next = cur; //将cur连接到新的链表上
           cur = next; //让cur后移
       }
       //将head.next指向reverseHead.next, 实现单链表的反转
       head.next = reverseHead.next;
   }
```

   * 在main方法中测试.

```java
   //加入
   singleLinkedList.add(hero1);
   singleLinkedList.add(hero4);
   singleLinkedList.add(hero2);
   singleLinkedList.add(hero3);
   
   //测试一下单链表的反转功能
   System.out.println("原来链表的情况~~");
   singleLinkedList.list();
   
   System.out.println("反转单链表~~");
   reverseList(singleLinkedList.getHead());
   singleLinkedList.list();
```

   

4. **[从尾到头打印单链表(百度, 要求方式1: 反向遍历. 方式2: stack栈)]()** :

   * 思路: 题目要求就是逆序打印单链表
     1. 方式1: 先将单链表进行反转操作, 然后再遍历即可, 这样做的问题是会破坏原来的单链表的结构, 不建议;
     2. 方式2:  可以利用栈这个数据结构, 将各个节点压入到栈中, 然后利用栈的先进后出的特点, 就实现了逆序打印的效果.
   * 演示栈Stack的基本使用:

```java
   public class TestStack {
       
       public static void main(String[] args) {
           Stack<String> stack = new Stack();
           //入栈
           stack.add("jack");
           stack.add("tom");
           stack.add("smith");
           
           //出战
           //smith, tom, jack
           while(stack.size() > 0) {
               System.out.println(stack.pop()); //pop就是将栈顶的数据取出
           }
       }
   }
```

   * 因为reversePrint方法是通用的, 所以reversePrint方法放在SingleLinkedListDemo类中, 并且声明为静态的.

```java
   //方式2:
   //可以利用栈这个数据结构, 将各个节点压入到栈中, 然后利用栈的先进后出的特点, 就实现了逆序打印的效果
   public static void reversePrint(HeroNode head) {
       if(head.next == null) {
           return; //空链表, 不能打印
       }
       //创建要给一个栈, 将各个节点压入栈
       Stack<HeroNode> stack = new Stack<HeroNode>();
       HeroNode cur = head.next;
       //将链表的所有节点压入栈
       while(cur != null) {
           stack.push(cur);
           cur = cur.next; //cur后移, 这样就可以压入下一个节点
       }
       //将栈中的节点进行打印, pop出栈
       while(stack.size() > 0) {
           System.out.println(stack.pop()); //stack的特点是先进后出
       }
   }
```

   * 在main方法中测试.

```java
   System.out.println("测试逆序打印单链表, 没有改变链表的结构~~");
   reversePrint(singleLinkedList.getHead());
```

   

5. **[合并两个有序的单链表, 合并之后的链表依然有序(课后练习)]()** 

#### 4. 双向链表

![](D:\java数据结构-figure\7.png)

1. **[单向链表的缺点]()** : 

   1. 单向链表查找的方向只能是**一个方向**, 而双向链表可以**向前后者向后**查找;
   2. 单向链表**不能自我删除**, 需要靠**辅助节点**, 而双向链表可以**自我删除**, 所以前面单链表删除节点时, 总是找到temp, temp是待删除节点的前一个节点.

2. **[双向链表的介绍]()** : (分析双向链表的遍历, 添加, 修改, 删除的操作思路)

   * **遍历** : 遍历方式和单链表一样, 只是可以向前, 也可以向后查找.
   * **添加** : (默认添加到双向链表的最后)
     1. 先找到双向链表的**最后这个节点**;
     2. `temp.next = newHeroNode`;
     3. `newHeroNode.pre = temp`.
   * **修改** : 思路, 原理和单向链表一样.
   * **删除** : 
     1. 因为是双向链表, 因此可以实现**自我删除**某个节点;
     2. 直接找到要删除的这个节点, 比如temp;
     3. `temp.pre.next = temp.next`;
     4. `temp.next.pre = temp.pre`.
   * **第二种添加方式** : 按照编号顺序添加.

3. **[双向链表增删改查代码实现]()** : 

```java
   public class DoubleLinkedListDemo {
       
       public class void main(stirng[] args) {
       	
           //测试
           System.out.println("双向链表的测试");
           //先创建节点
           HeroNode2 hero1 = new HeroNode2(1, "宋江", "及时雨");
           HeroNode2 hero2 = new HeroNode2(2, "卢俊义", "玉麒麟");
           HeroNode2 hero3 = new HeroNode2(3, "吴用", "智多星");
           HeroNode2 hero4 = new HeroNode2(4, "林冲", "豹子头");
           //创建一个双向链表
           DoubleLinkedList doublelinkedlist = new DoubleLinkedList();
           doublelinkedlist.add(hero1);
           doublelinkedlist.add(hero2);
           doublelinkedlist.add(hero3);
           doublelinkedlist.add(hero4);
           
           doublelinkedlist.list();
           
           //修改
           HeroNode2 newHeroNode = new HeroNode2(4, "公孙胜", "入云龙");
           doublelinkedlist.update(newHeroNode);
           System.out.println("修改后的链表情况");
           doublelinkedlist.list();
           
           //删除
           doublelinkedlist.del(3);
           System.out.println("删除后的链表情况~~");
           doublelinkedlist.list();
       }
   }
   
   //创建一个双向链表的类
   class DoubleLinkedList {
       
       //先初始化一个头结点, 头结点不要动, 不存放具体的数据
       private HeroNode2 head = new HeroNode2(0, "", "");
       
       //返回头节点
       public HeroNode2 getHead() {
           return head;
       }
       
       //遍历双向链表的方法
       //显示链表[遍历]
       public void list() {
           //判断链表是否为空
           if(head.next == null) {
               System.out.println("链表为空");
               return;
           }
           //因为头结点, 不能动, 因此需要一个辅助变量来遍历
           HeroNode2 temp = head;
           while(true) {
               //判断是否到链表最后
               if(temp == null) {
                   break;
               }
               //输出节点的信息
               System.out.println(temp); //调用HeroNode的toString方法
               //将temp后移, 一定小心
               temp = temp.next;
           }
       }
       
       //添加一个节点到双向链表的最后
       public void add(HeroNode2 heroNode) {
       
           //因为head节点不能动, 因此需要一个辅助遍历temp
           HeroNode2 temp = head;
           //遍历链表, 找到最后
           while(true) {
               //找到链表的最后
               if(temp.next == null) {
                   break;
               }
               //如果没有找到最后, 将temp后移
               temp = temp.next;
           }
           //当退出while循环时, temp就指向了链表的最后
           //形成了一个双向链表
           temp.next = heroNode;
           heroNode.pre = temp;
       }
       
       //修改一个节点的内容, 可以看到双向链表的节点内容修改和单向链表一样
       //只是节点类型改成HeroNode2
       public void update(HeroNode2 newHeroNode) {
           //判断是否空
           if(head.next == null) {
               System.out.println("链表为空~");
               return;
           }
           //找到需要修改的节点, 根据no编号
           //定义一个辅助变量
           HeroNode2 temp = head.next;
           boolean flag = false; //表示是否找到该节点
           while(true) {
               if(temp == null) {
                   break; //已经遍历完列表了
               }
               if(temp.no == newHeroNode.no) {
                   //找到了
                   flag = true;
                   break;
               }
               temp = temp.next;
           }
           //根据flag判断是否找到要修改的节点
           if(flag) {
               temp.name = newHeroNode.name;
               temp.nickname = newHeroNode.nickname;
           }else { //没有找到
               System.out.printf("没有找到编号%d的节点, 不能修改\n", newHeroNode.no);
           }
   	}
       
       //从双向链表中删除一个节点
       //说明
       //1. 对于双向链表, 可以直接找到要删除的这个节点
       //2. 找到后,自我删除即可
       public void del(int no) {
           
           //判断链表是否为空
           if(head.next == null) { //空链表
               System.out.println("链表为空, 无法删除");
               return;
           }
           
           HeroNode temp = head.next; //辅助变量(指针)
           HeroNode temp = head; //保证可以删除第一个节点
           boolean flag = false; //标志是否找到待删除节点
           while(true) {
               if(temp == null) { //已经到链表的最后节点的next
                   break;
               }
               if(temp.no = no) {
                   //找到待删除节
                   flag = true;
                   break;
               }
               temp = temp.next;
           }
           //判断flag
           if(flag) { //找到
               //可以删除
               //temp.next = temp.next.next; [单链表]
               temp.pre.next = temp.next;
            //这里代码有问题?
               //如果是最后一个节点, 就不需要执行下面这行代码, 否则就会出现空指针异常
               if(temp.next != null) {
                   temp.next.pre = temp.pre;
               }
           }else {
               System.out.println("要删除的%d节点不存在\n", no);
           }
       }
   }
   
   //定义HeroNode2, 每个HeroNode对象就是一个节点
   class HeroNode2 {
       
       public int no;
       public String name;
       public String nickname;
       public HeroNode2 next; //指向下一个节点, 默认为null
       public HeroNode2 pre; //指向前一个节点, 默认为null
       
       //构造器
       public HeroNode2(int no, String name, String nickname) {
           this.no = no;
           this.name = name;
           this.nickname = nickname;
       }
       
       //为了显示方法, 重写toString
       public void toString() {
           return "HeroNode2[no=" + no + ",name=" + name + ",nickname=" + nickname + "]";
       }
   }
```


#### 5. 环形链表介绍和约瑟夫环问题

1. **[单向环形链表应用场景]()** : 

   ![](D:\java数据结构-figure\8.png)

2. **[约瑟夫环示意图]()** : 

   ![](D:\java数据结构-figure\9.png)

3. **[单向的环形链表的创建和遍历的思路]()** : 

   * **创建** : 
     1. 先创建第一个节点, **让first指向该节点**, 并形成环形, 注意first不能动;
     2. 后面当每创建一个新的节点, 就把该节点加入到已有的环形链表中即可.
   * **遍历** : 
     1. 先让一个辅助指针(变量curBoy), 指向first节点;
     2. 然后通过一个while循环遍历该环形链表即可, 当`curBoy.next = first`时结束.

4. **[单向环形链表的代码实现]()** :
```java
   public class Josepfu {
       
       public static void main(String[] args) {
           //测试一把看看构建环形链表, 和遍历是否ok
           CircleSingleLinkedList circleSingleLinkedList = new CircleSingleLinkedList();
           circleSingleLinkedList.addBoy(5); //加入5个小孩节点
           circleSingleLinkedList.showBoy();
           
       }
   }
   
   //创建一个环形的单向链表
   class CircleSingleLinkedList {
       //创建一个first节点, 当前没有编号
       private Boy first = new Boy(-1);
       //添加小孩节点, 构成一个环形的链表
       public void addBoy(int nums) {
           //nums做一个数据校验
           if(nums < 1) {
               System.out.println("nums的值不正确");
               return;
           }
           Boy curBoy = null; //辅助指针, 帮助构建环形链表
           //使用for来创建环形链表
           for(int i = 1; i < nums; i++) {
               //根据编号, 创建小孩节点
               Boy boy = new Boy(i);
               //如果是第一个小孩
               if(i == 1) {
                   first = boy;
                   first.setNext(first); //构成环
                   curBoy = first; //让curBoy指向第一个小孩
               } else {
                   curBoy.setNext(boy); //
                   boy.setNext(first); //
                   curBoy = boy;
               }
           }
       }
       
       //遍历当前环形链表
       public void showBoy() {
           //判断链表是否为空
           if(first == null) {
               System.out.println("没有任何小孩~~");
               return;
           }
           //因为first不能动, 因此要使用一个辅助指针完成遍历
           Boy curBoy = first;
           while(true) {
               System.out.printf("小孩的编号%d\n", curBoy.getNo());
               if(curBoy.getNext() == first) { //说明已经遍历完毕
                   break;
               }
               curBoy = curBoy.getNext(); //curBoy后移
           }
       }
   }
   
   //创建一个Boy类, 表示一个节点
   class Boy {
       
       private int no; //编号
       private Boy next; //指向下一个节点, 默认null
       
       public Boy(int no) {
           this.no = no;
       }
       
       public int getNo() {
           return no;
       }
       
       public void setNo(int no) {
           this.no = no;
       }
       
       public Boy getNext() {
           return next;
       }
       
       public void setNext(Boy next) {
           this.next = next;
       }
   }
```

5. **[约瑟夫环问题的思路]()** : (根据用户的输入, 生成一个小孩出圈的顺序. n=5表示有5个人, k=1表示从第一个人开始报数, m=2表示数2下.)

   1. 需要创建一个**辅助指针(变量)helper**, 事先应该指向环形链表的最后这个节点;

   2. 小孩报数前, 先让first和helper移动k-1次;

   3. 当小孩报数时, 让first和helper指针同时的移动m-1次; (报数时, first指向的节点本身算一次)

   4. 这时就可以将first指向的小孩节点出圈:

      * `first = first.next;` (当下一次报数时, 就可以从first开始了)
      * `helper.next = first;`

      原来first指向的节点就没有任何引用, 就会被回收.

6. **[约瑟夫环问题的代码实现]()** : 

   * 将countBoy方法放在CircleSingleLinkedList类中.

```java
   //根据用户的输入, 计算出小孩出圈的顺序
   //startNo: 表示从第几个小孩开始数数; 
   //countNum: 表示数几下;
   //nums: 表示最初有多少小孩在圈中.
   public void countBoy(int startNo, int countNum, int nums) {
       //先对数据进行校验
       if(first == null || startNo < 1 || startNo > nums) { //边界处理
           System.out.println("参数输入有误, 请重新输入");
           return;
       }
       //创建要给辅助指针, 帮助完成小孩出圈
       Boy helper = first;
       //需要创建一个辅助指针(变量)helper, 事先应该指向环形链表的最后这个节点
       while(true) {
           if(helper.getNext() == first) { //说明helper指向最后小孩节点
               break;
           }
           helper = helper.getNext();
       }
       //小孩报数前, 先让first和helper移动k-1次
       for(int j = 0; j < startNo - 1; j++) {
           first = first.getNext();
           helper = helper.getNext();
       }
       //当小孩报数时, 让first和helper指针同时移动m-1次, 然后出圈
       //这里是一个循环操作, 直到圈中只有一个节点
       while(true) {
           if(helper == first) { //说明圈中只有一个节点
               break;
           }
           //让first和helper指针同时的移动countNum-1
           for(int j = 0; j < countNum - 1; j++) {
               first = first.getNext();
               helper = helper.getNext();
           }
           //这时first指向的节点, 就是要出圈的小孩节点
           System.out.printf("小孩%d出圈\n", first.getNo());
           //这时将first指向的小孩节点出圈
           first = first.getNnext();
           helper.setNext = first;
       }
       System.out.println("最后留在圈中的小孩编号%d\n", first.getNo());
   }
```

   * 测试代码, 放在main方法中.

```java
   //测试一把小孩出圈是否正确
   circleSingleLinkedList.countBoy(1, 2, 5); //2->4->1->5->3
```



## 栈

#### 1. 栈的应用场景和介绍

1. **[栈的一个实际需求]()** : 

   ![](D:\java数据结构-figure\10.png)

2. **[栈的介绍]()** : 

   1. 栈的英文名为stack;
   2. 栈是一个**先入后出**的有序列表;
   3. 栈是限制线性表中元素的插入和删除**只能在线性表的同一端**进行的一种特殊线性表. 允许插入和删除的一端为变化的一端, 称为**栈顶(top)**, 另一端为固定的一端, 称为**栈底(bottom)**;
   4. 根据栈的定义可知, 最先放入栈中元素在栈底, 最后放入的元素在栈顶, 而删除元素刚好相反, 最后放入的元素最先删除, 最先放入的元素最后删除.
   5. 出栈(pop)和入栈(push)的概念.

3. **[栈的应用场景]()** : 

   1. **子程序的调用**: 在跳往子程序前, 会先将下一个指令的地址存到堆栈中, 直到子程序执行完后再将地址取出, 以回到原来的程序中. (return语句)
   2. **处理递归调用**: 和子程序的调用类似, 只是除了储存下一个指令的地址外, 也将参数, 区域变量等数据存入堆栈中.
   3. **表达式的转换[中缀表达式转后缀表达式]与求值(实际解决)**.
   4. **二叉树的遍历**.
   5. **图的深度优先搜索法**.

#### 2. 数组模拟栈

1. **[栈的快速入门]()** : 

   1. 用**数组**模拟栈的使用, 由于栈是一种有序列表, 当然可以使用数组的结构来储存栈的数据内容, 所以用数组模拟栈的出栈, 入栈等操作.

   2. 实现栈思路分析及示意图: 

      * 使用数组来模拟栈;
      * 定义一个top来表示栈顶, **初始化为-1**;
      * 入栈的操作, 当有数据加入到栈时, `top++; stack[top] = data;`
      * 出栈的操作, `int value = stack[top]; top--; return value;`

      ![](D:\java数据结构-figure\11.png)

   3. 改成使用**链表**来模拟栈.

2. **[使用数组模拟栈的代码实现]()** : 

```java
   public class ArrayStackDemo {
       
       public static void main(String[] args) {
       	///测试一下ArrayStack是否正确
           //先创建一个ArrayStack对象->表示栈
           ArrayStack stack = new ArrayStack(4);
           String key = "";
           boolean loop = true; //控制是否退出菜单
           Scanner scanner = new Scanner(System.in);
           
           while(loop) {
               System.out.println("show: 表示显示栈");
               System.out.println("exit: 退出程序");
               System.out.println("push: 表示添加数据庝栈(入栈)");
               System.out.println("pop: 表示从栈中取出数据(出栈)");
               System.out.println("经输入你的选择:");
               key = scanner.next();
               switch(key) {
                   case "show":
                       stack.list();
                       break;
                   case "push":
                       System.out.println("请输入一个数");
                       int value = scanner.nextInt();
                       stack.push(value);
                   case "pop":
                       try {
                           int res = stack.pop();
                           System.out.printf("出栈的数据是%d\n", res);
                       } catch (EXception e) {
                           System.out.println(e.getMessage());
                       }
                       break;
                   case "exit":
                       scanner.close();
                       loop = false;
                       break;
                   default:
                       break;
               }
           }
           
           System.out.println("程序退出~~");
   	}
   } 
   
   //定义一个ArrayStack表示栈
   class ArrayStack {
       private int maxSize; //栈的大小
       private in[] stack; //数组, 数组模拟栈, 数据就放在该数组中
       private int top = -1; //top表示栈顶, 初始化为-1
       
       //构造器
       public ArrayStack(int maxSize) {
           this.maxSize = maxSize;
           stack = new int[maxSize];
       }
       
       //栈满
       public boolean isFull() {
           return top == maxSize - 1;
       }
       
       //栈空
       public boolean isEmpty() {
           return top == -1;
       }
       
       //入栈-push
       public void push(int value) {
           
           //先判断栈是否满
           if(isFull()) {
               System.out.println("栈已经满了");
               return;
           }
           top++;
           stack[top] = value;
       }
       
       //出栈-pop, 将栈顶的数据返回
       public int pop() {
           
           //先判断栈是否为空
           if(isEmpty()) {
               //抛出异常
               throw new RunTimeException("栈空, 没有数据~");
           }
           
           int value = stack[top];
           top--;
           return value;
       }
       
       //显示栈的情况[遍历栈], 遍历时, 需要从栈顶开始显示数据
       public void list() {
           
           //先判断是否栈空
           if(ifEmpty) {
               throw new RunTimeException("栈空, 没有数据~~");
           }
           
           //需要从栈顶开始显示数据
           //方式1: 使用while循环, 注意: 这种方式已经破坏了栈, 只能看一遍数据, 看完后, 就没有数据了, 所以这种方式不推荐
           while(top != -1) {
               int value = pop();
               System.out.printf(value);
           }
           //方式2: 使用for循环 [推荐]
           for(int i = top; i >= 0; i--) {
               System.out.printf("stack[%d]=%d\n", i, stack[i]);
           }
           
           return;
       }
   }
```

#### 3. 栈实现综合计算器(中缀表达式)

![](D:\java数据结构-figure\12.png)

1. **[使用栈完成表达式的计算思路]()** :

   ![](D:\java数据结构-figure\13.png)

   1.  通过一个`index`值(索引), 来**遍历**表达式
   2. 如果发现是一个数字, 就直接进入数栈(numStack)
   3. 如果发现扫描到的是一个符号, 就分如下情况:
      * 如果发现当前的符号栈为空, 就直接进入;
      * 如果符号栈(operStack)有操作符, 就进行比较, 如果**当前的操作符的优先级小于或者等于栈中的操作符**, 就需要从数栈中pop出两个数, 再从符号栈中pop出一个符号, 进行运算, 将得到的结果入数栈, 然后将当前的操作符入符栈, 如果**当前的操作符的优先级大于栈中的操作符**, 就直接入符号栈.
   4. 当表达式扫描完毕, 就顺序的从数栈和符号栈中pop出相应的数和符号, 并运算
   5. 最后在数栈中只有一个数字, 就是表达式的结果.

2. **[代码实现]()** : 

   * 先实现一位数的运算, 扩展到多位数的运算.

```java
   public class Calculator {
       
       public static void main(String[] args) {
           //根据思路, 完成表达式的运算
           String expression = "3+2*6-2"; 
           //创建两个栈, 一个数栈, 一个符栈
           ArrayStack2 numStack = new ArrayStack2(10);
           ArrayStack2 operStack = new ArrayStack2(10);
           //定义需要的相关变量
           int index = 0; //用于扫描
           int num1 = 0;
           int num2 = 0;
           int oper = 0;
           int res = 0;
           char ch = ' '; //将每次扫描得到char保存到ch
           String keepNum = ""; //用于拼接多位数
           //开始while循环的扫描expression
           while(true) {
               //if(index == expression.length()) { //退出循环的条件, 可以写在前面, 也可以写在后面
               //    break;
               //}
               //依次得到expression的每一个字符
               //注意: substring返回的是字符串, charAt返回的是字符, 现在需要得到一个字符
               //下面这行代码等同于 ch = expression.charAt(index);
               ch = expression.substring(index, index + 1).charAt(0);
               //判断ch是什么, 然后做相应的处理
               if(operStack.isOper(ch)) { //如果是运算符
                   //判断当前的符号栈是否为空
                   if(!operStack.isEmpty()) {
                       //如果符号栈有操作数, 就进行比较, 如果当前的操作符的优先级小于或等于栈中的操作符, 就需要从数栈中pop出两个数, 再从符号栈中pop出一个符号, 进行运算, 将得到结果入数栈, 然后将当前的操作符入符号栈
                       if(operStack.priority(ch) <= operStack.priority(operStack.peek())) {
                           num1 = numStack.pop();
                           num2 = numStack.pop();
                           oper = operStack.pop();
                           res = numStack.cal(num1, num2, oper);
                           //把运算结果入数栈
                           numStack.push(res);
                           //然后将当前的操作符入符号栈
                           operStack.push(ch);
                       } else {
                           //如果当前的操作符的优先级大于栈中的操作符, 就直接入栈
                           operStack.push(ch);
                       }
                   }else {
                       //如果为空直接入符号栈
                       operStack.push(ch);
                   }
               }else { //如果是数, 则直接入数栈
                   //numStack.push(ch - 48); //字符1的ASCII值为49, 字符0的ASCII值为48, 所以ch-48就相当于ch-'0'
                   ////如何处理多位数的问题?
                   //分析思路
                   //1.当处理多位数时, 不能发现是一个数就立即入栈, 因为它可能是多位数
                   //2.在处理数时, 需要向expression的表达式的index后再看一位, 如果是数就进行扫描, 如果是符号才入栈 (注意: 只是看, 不对其进行操作)
                   //3.因此需要定义一个变量字符串, 用于拼接
                   
                   //处理多位数
                   keepNum += ch;
                   
                   //如果ch已经是expression的最后一位, 就直接入栈
                   if(index == expression.length() - 1) { //这行代码很重要, 如果没有, 就会出错: 数组越界
                       numStack.push(Integer.parseInt(keepNum));
                   }else {
                       //判断下一个字符是不是数字, 如果是数字就继续扫描, 如果是运算符, 则入栈
                   //注意是看后一位, 不是index++
                   
                       if(operStack.isOper(expression.substring(index + 1, index + 2).charAt(0))) {
                           //如果后一位是运算符, 则入栈keepNum = "1" 或者 "123"
                           numStack.push(Integer.parseInt(keepNum));
                           //重要!!!, keepNum清空
                           keepNum = "";
                       }
                   } 
               }
               //让index + 1, 并判断是否扫描到expression最后
               index++;
               if(index >= expression.length()) {
                   break;
               }
           }
           
           //当表达式扫描完毕, 就顺序从数栈和符号栈中pop出相应的数和符号, 并运算
           while(true) {
               //如果符号栈为空, 则计算到最后的结果, 数栈中只有一个数字[结果]
               if(operStack.isEmpty()) { //循环退出条件
                   break;
               }
               num1 = numStack.pop();
               num2 = numStack.pop();
               oper = operStack.pop();
               res = numStack.cal(num1, num2, oper);
               numStack.push(res); //入栈
           }
           //将数栈的最后数pop出, 就是结果
           System.out.printf("表达式%s=%d\n", expression, numStack.pop());
       }
   }
   
   //先创建一个栈, 直接使用前面创建好的
   //定义一个ArrayStack2表示栈, 需要扩展功能
   class ArrayStack2 {
       private int maxSize; //栈的大小
       private in[] stack; //数组, 数组模拟栈, 数据就放在该数组中
       private int top = -1; //top表示栈顶, 初始化为-1
       
       //构造器
       public ArrayStack(int maxSize) {
           this.maxSize = maxSize;
           stack = new int[maxSize];
       }
       
       //增加一个方法, 额可以返回当前栈顶的值, 但是不是真正的pop
       public int peek() {
           return stack[top];
       }
       
       //栈满
       public boolean isFull() {
           return top == maxSize - 1;
       }
       
       //栈空
       public boolean isEmpty() {
           return top == -1;
       }
       
       //入栈-push
       public void push(int value) {
           
           //先判断栈是否满
           if(isFull()) {
               System.out.println("栈已经满了");
               return;
           }
           top++;
           stack[top] = value;
       }
       
       //出栈-pop, 将栈顶的数据返回
       public int pop() {
           
           //先判断栈是否为空
           if(isEmpty()) {
               //抛出异常
               throw new RunTimeException("栈空, 没有数据~");
           }
           
           int value = stack[top];
           top--;
           return value;
       }
       
       //显示栈的情况[遍历栈], 遍历时, 需要从栈顶开始显示数据
       public void list() {
           
           //先判断是否栈空
           if(ifEmpty) {
               throw new RunTimeException("栈空, 没有数据~~");
           }
           
           //需要从栈顶开始显示数据
           //方式1: 使用while循环, 注意: 这种方式已经破坏了栈, 只能看一遍数据, 看完后, 就没有数据了, 所以这种方式不推荐
           while(top != -1) {
               int value = pop();
               System.out.printf(value);
           }
           //方式2: 使用for循环 [推荐]
           for(int i = top; i >= 0; i--) {
               System.out.printf("stack[%d]=%d\n", i, stack[i]);
           }
           
           return;
       }
       
       //返回运算符的优先级, 优先级是程序员来确定, 优先级使用数字表示
       //数字越大, 则优先级就越高
       public int priority(char oper) { //注意: 参数类型为int也可以, 因为char底层也是int
           if(oper == '*' || oper == '/') {
               return 1;
           }else if(oper == '-' || oper == '+') {
               return 0;
           }else {
               return -1; //假定目前的表达式只有+,-,*,/
           }
       }
       
       //判断是不是一个运算符
       public boolean isOper(char val) {
           return val == '+' || val == '-' || val == '*' || val == '/';
       }
       
       //计算方法
       public int cal(int num1, int num2, int oper) { //注意: oper可以为char类型, 也可以为int类型
           int res == 0; //res用于存放计算的结果
           swith(oper) {
               case '+':
               	res = num1 + num2;
               	break;
               case '-':
               	res = num2 - num1; //注意顺序
               	break;
               case '*':
               	res = num1 * num2;
               	break;
               case '/':
               	res = num2 / num1;
               	break;
               default:
               	break;
           }
           return res;
       }
       
   }
```

3. **[前缀,中缀,后缀表达式规则]()** : 

   1. **前缀表达式(波兰表达式)** : 
      * 前缀表达式又称波兰式, 前缀表达式的运算符位于操作数之前.
      * 举例说明: (3+4)*5-6对应的前缀表达式就是`-*+3456`.
      * 前缀表达式的计算机求值: **从右至左扫描表达式**, 遇到数字时将数字压入堆栈, 遇到运算符时弹出栈顶的两个数, 用运算符对它们做相应的计算(栈顶元素和次顶元素), 并将结果入栈; 重复上述过程直到表达式最左端, 最后运算得出的值即为表达式的结果.
   2. **中缀表达式** :
      * 中缀表达式的求值对计算机来说不好操作, 所以在计算结果时, 往往会将中缀表达式转成其它表达式来操作. (**一般转成后缀表达式**)
   3. **后缀表达式(逆波兰表达式)** :
      * 后缀表达式又称逆波兰表达式, 与前缀表达式相似, 只是运算符位于操作数之后.
      * 举例说明: (3+4)*5-6对应的后缀表达式就是`34+5*6-`.
      * 后缀表达式的计算机求值: **从左至右扫描表达式**, 遇到数字时将数字压入堆栈, 遇到运算符时弹出栈顶的两个数, 用运算符对它们做相应的计算(次顶元素和栈顶元素), 并将结果入栈; 重复上述过程直到表达式最右端, 最后运算得出的值即为表达式的结果.

#### 4. 逆波兰计算器(后缀表达式)

![](D:\java数据结构-figure\14.png)

1. **[思路分析]()** :

   ![](D:\java数据结构-figure\15.png)

2. **[代码实现]()** : 

```java
   public class PolandNotation {
       
       public static void main(String[] args) {
           //先定义给逆波兰表达式
           //(3+4)×5-6 => 3 4 + 5 × 6 -
           //说明: 为了方便, 逆波兰表达式的数字和符号使用空格隔开
           String suffixExpression = "3 4 + 5 × 6 -";
           //思路:
           //1. 先将"3 4 + 5 × 6 -" => 放到ArrayList中
           //2. 将ArrayList传递给一个方法, 遍历ArrayList, 配合栈完成计算
           
           List<String> rpnList = getListString(suffixExpression);
           System.out.println("rpnList=" + rpnList);
           int res = nblCalculator(rpnList);
           System.out.println("计算的结果是=" + res);
       }
       
       //将一个逆波兰表达式, 依次将数据和运算符放入到ArrayList中
       public static List<String> getListString(String suffixExpression) {
           //将suffixExpression分割
           String[] split = suffixExpression.split(" ");
           List<String> list = new ArrayList<String>();
           //遍历字符串数组, 将数组中的元素依次放入到列表中
           //由于只需要元素, 不需要下标, 所以可以使用增强for循环
           for(String ele: split) {
               list.add(ele);
           }
           return list;
       }
       
       //完成对逆波兰表达式的运算
       /*
        * 1.从左至右扫描, 将3和4压入堆栈;
        * 2.遇到+运算符, 因此弹出4和3(4为栈顶元素, 3为次顶元素), 计算出3+4的值, 得7, 再将7入栈;
        * 3.将5入栈;
        * 4.接下来是×运算符, 因此弹出5和7, 计算出7×5=35, 将35入栈;
        * 5.将6入栈;
        * 6.最后是-运算符, 计算出35-6的值, 即29, 由此得出最终结果.
        */
       public static int nblCalculator(List<String> rpnList) {
           //创建一个数栈, 只需要一个栈即可
           //Stack<Integer> numStack = new Stack<String>();
           Stack<String> numStack = new Stack<String>();
           
           //遍历ArrayList集合的方式1: 使用迭代器
           //得到列表的迭代器
           Iterator it = rpnList.iterator();
           //遍历
           while(it.hasNext()) {
               String curstr = it.next();
               //判断是数字
               //if(curstr >= 48 && curstr <= 58) { //这里有问题, 如果是多位数, 则这么判断就是错误的
               if(curstr.matches("\\d+")) { //使用正则表达式判断是否是数字字符串
                   numStack.push(Integer.parseInt(curstr)); //数字字符串转为数字方式一
                   //numStack.push(curstr - 48); //数字字符串转为数字方式二, 如果是多位数, 则这么判断就是错误的
               } else { //判断是操作符, 则进行相应的运算
                   int num1 = numStack.pop();
                   int num2 = numStack.pop();
                   int result = 0;
                   switch(curstr) {
                       case "+": 
                           result = num1 + num2;
                           numStack.push(result);
                           break;
                       case "-":
                           result = num2 - num1;
                           numStack.push(result);
                           break;
                       case "×":
                           result = num1 × num2;
                           numStack.push(result);
                           break;
                       case "/":
                           result = num2 / num1;
                           numStack.push(result);
                           break;
                       default:
                           break;
                   }
               }
           }
           
           //遍历ArrayList集合的方式二: for循环(使用迭代器)
           //遍历rpnList
           for(String item : rpnList) {
               //这里使用正则表达式来取出数
               if(item.matches("\\d+")) { //匹配的是多位数
                   //入栈
                   numStack.push(item);
               } else {
                   //pop出两个数, 并运算, 再入栈
                   //注意: 可以用switch语句, 也可以使用if语句
                   int num2 = Integer.parseInt(numStack.pop());
                   int num1 = Integer.parseInt(numStack.pop());
                   int res = 0;
                   if(item.equals("+")) {
                       res = num1 + num2;
                   } else if(item.equals("-")) {
                       res = num1 - num2;
                   } else if(item.equals("×")) {
                       res = num1 × num2;
                   } else if(item.equals("/")) {
                       res = num1 / num2;
                   } else {
                       //如果不是这四个符号, 则抛出一个异常
                       throw new RunTimeException("符号有问题!");
                   }
                   //把运算结果入栈(res)
                   numStack.push(res + "");
               }
           }
           //最后留在栈中的数据就是表达式的运算结果
           return Integer.parseInt(numStack.pop());
       }
        
       
   }
```

#### 5. 中缀表达式转后缀表达式

1. **[思路分析]()** : 

   ![](D:\java数据结构-figure\16.png)

   ![](D:\java数据结构-figure\17.png)

2. **[举例说明]()** : 

   ![](D:\java数据结构-figure\18.png)

3. **[代码实现]()** : 

   * 在PolandNotation类中写一个将中缀表达式转成对应的List的静态方法toInfixExpressionList.

```java
   //方法: 将中缀表达式转成对应的List
   //s="1+((2+3)×4)-5"
   public static List<String> toInfixExpressionList(String s) {
       //定义一个List, 存放中缀表达式对应的内容
       List<String> ls = new ArrayList<String>();
       int i = 0; //这时是一个指针, 用于遍历中缀表达式字符串
       String str; //对多位数的拼接
       char c; //每遍历到一个字符, 就放入到c
       do {
           //如果c是一个非数字, 需要加入到ls
           if((c=s.charAt(i))<48 || (c=s.charAt(i))>57) {
               ls.add("" + c);
               i++; //i需要后移
           } else { //如果是一个数, 需要考虑多位数
               str = ""; //先将str置成""
               while(i<s.length() && (c=s.charAt(i)) >= 48 && (c=s.charAt(i)) <=57) {
                   str += c; //拼接
                   i++;
               }
               ls.add(str);
           }
       }while(i < s.length());
       return ls;
   }
```

   * 在PolandNotation类中写一个将得到的中缀表达式对应的List转成后缀表达式对应的List的静态方法parseSuffixExpressionList.

```java
   //即ArrayList[1,+,(,(,2,+,3,),×,4,),-,5] => ArrayList[1,2,3,+,4,×,+,5,-]
   //方法: 将得到的中缀表达式对应的List => 后缀表达式对应的List
   public static List<String> parseSuffixExpressionList(List<String> ls) {
       //定义两个栈
       Stack<String> s1 = new Stack<String>();
       //说明: 因为s2这个栈, 在整个转换过程中, 没有pop操作, 而且后面还需要逆序输出
       //因此比较麻烦, 这里就不用Stack<String>, 直接使用List<String> s2
       //Stack<String> s2 = new Stack<String>(); //储存中间结果的栈s2
       List<String> s2 = new ArrayList<String>(); //储存中间结果的List<String> s2
       
       //遍历ls
       for(String item : ls) {
           //如果是一个数, 加入s2
           if(item.matches("\\d+")) {
               s2.add(item);
           } else if(item.equals("(")) {
               s1.push(item);
           } else if(item.equals(")")) {
               //如果是右括号")", 则依次弹出s1栈顶的运算符, 并压入s2, 直到遇到左括号为止, 此时将这一对括号丢弃
               while(!s1.peek().equals("(")) {
                   s2.add(s1.pop());
               }
               s1.pop(); //!!! 将(弹出s1栈, 消除小括号
           } else {
               //当item的优先级小于等于s1栈顶运算符, 将s1栈顶的运算符弹出并加入到s2中, 再次转到(4.1)与s1中新的栈顶运算符相比较
               //问题: 缺少一个比较优先级高低的方法
               while(s1.size() != 0 && Operation.getValue(s1.peek()) >= Operation.getValue(item)) {
                   s2.add(s1.pop());
               }
               //还需要将item压入栈
               s1.push(item);
           }
       }
       
       //将s1中剩余的运算符依次弹出并加入s2
       while(s1.size() != 0) {
           s2.add(s1.pop());
       }
       
       return s2; //注意: 因为是存放到List, 因此按顺序输出就是对应的后缀表达式对应的List
   }
```

   * 在PolandNotation类所在的包下写一个Operation类, 该类可以返回一个运算符对应的优先级.

```java
   //编写一个类Operation可以返回一个运算符对应的优先级
   class Operation {
       private static int ADD = 1;
       private static int SUB = 1;
       private static int MUL = 2;
       private static int DIV = 2;
       
       //写一个方法, 返回对应的优先级数字
       public static int getValue(String operation) {
           int result = 0;
           switch(operation) {
               case "+":
                   result = ADD;
                   break;
               case "-":
                   result = SUB;
                   break;
               case "×":
                   result = NUL;
                   break;
               case "/":
                   result = DIV;
                   break;
               default:
                   System.out.println("不存在该运算符");
                   break;
           }
           return result;
       }
   }
```

   * 在PolandNotation类的main方法中写测试代码.

```java
   //完成将一个中缀表达式转成后缀表达式的功能
   //说明
   //1. 1+((2+3)×4)-5 => 1 2 3 + 4 × + 5 -
   //2. 因为直接对str进行操作不方便, 因此先将"1+((2+3)×4)-5" => 中缀表达式对应的List
   //   即"1+((2+3)×4)-5" => ArrayList[1,+,(,(,2,+,3,),×,4,),-,5]
   //3. 将得到的中缀表达式对应的List => 后缀表达式对应的List
   //   即ArrayList[1,+,(,(,2,+,3,),×,4,),-,5] => ArrayList[1,2,3,+,4,×,+,5,-]
   String expression = "1+((2+3)×4)-5";
   List<String> infixExpressionList = toInfixExpressionList(expression);
   System.out.println("中缀表达式对应的List" + infixExpressionList); //ArrayList[1,+,(,(,2,+,3,),×,4,),-,5]
   List<String> suffixExpressionList = parseSuffixExpressionList(infixExpressionList);
   System.out.println("后缀表达式对应的List" + suffixExpressionList); //ArrayList[1, 2, 3, +, 4, ×, +, 5, -]
   System.out.println("expression=%d", calculate(suffixExpressionList));
```

#### 6. 逆波兰计算器完整版

1. **[需求]()** :

   ![](D:\java数据结构-figure\19.png)

2. **[代码实现]()** : 

   ![](D:\java数据结构-figure\21.png)

   ![](D:\java数据结构-figure\23.png)

   ![](D:\java数据结构-figure\22.png)

   ![](D:\java数据结构-figure\26.png)

   ![](D:\java数据结构-figure\25.png)

   ![](D:\java数据结构-figure\24.png)

   ![](D:\java数据结构-figure\27.png)

   ![](D:\java数据结构-figure\28.png)

   ![](D:\java数据结构-figure\29.png)

   ![](D:\java数据结构-figure\30.png)

   ![](D:\java数据结构-figure\31.png)

   ![](D:\java数据结构-figure\32.png)

   ![](D:\java数据结构-figure\33.png)

   ![](D:\java数据结构-figure\34.png)

   ![](D:\java数据结构-figure\35.png)



## 递归

#### 1. 递归应用场景和调用机制

1. **[递归应用场景]()** : 

   ![](D:\java数据结构-figure\36.png)

2. **[递归的概念]()** :

   * 简单的说: 递归就是方法自己调用自己, 每次调用时传入不同的变量. 递归有助于编程者解决复杂的问题, 同时可以让代码变得简洁.

3. **[递归的调用机制(重要)]()** : 

   ![](D:\java数据结构-figure\37.png)

4. **[递归能解决的问题和规则]()** : 

   * 递归能解决的问题: 
     1. 各种**数学问题**, 如: 八皇后问题, 汉诺塔, 阶乘问题, 迷宫问题, 球和篮子的问题(google编程大赛);
     2. 各种**算法**中也会使用到递归, 比如快排, 归并排序, 二分查找, 分治算法等;
     3. 将**用栈解决的问题** --> 递归代码比较简洁.
   * 递归需要遵守的重要规则:
     1. 执行一个方法时, 就创建一个新的受保护的**独立空间**(栈空间);
     2. 方法的**局部变量是独立的**, 不会相互影响;
     3. 如果方法使用的是**引用类型变量(比如数组)**, 就会**共享该引用类型的数据**;
     4. 递归必须**向退出递归的条件逼近**, 否则就是无限递归, 出现`StackOverflowError`, 死龟了;
     5. 当一个方法**执行完毕**, 或者**遇到return**, 就会返回, **遵守谁调用, 就将结果返回给谁**, 同时**当方法执行完毕或者返回时, 该方法也就执行完毕**了.

#### 2. 迷宫回溯问题分析和实现

1. **[迷宫问题]()** : 

   ![](D:\java数据结构-figure\38.png)

2. **[代码实现]()** : 

```java
   public class MiGong {
       
       public static void main(String[] args) {
           //先创建一个二维数组, 模拟迷宫
           //地图
           int[][] map = new int[8][7];
           //使用1表示墙
           //上下全部置为1
           for(int i = 0; i < 7; i++) {
               map[0][i] = 1;
               map[7][i] = 1;
           }
           
           //左右全部置为1
           for(int i = 0; i < 8; i++) {
               map[i][0] = 1;
               map[i][6] = 1;
           }
           
           //设置挡板, 1表示
           map[3][1] = 1;
           map[3][2] = 1;
           
           //输出地图
           System.out.println("地图的情况");
           for(int i = 0; i < 8; i++) {
               for(int j = 0; j < 7; j++) {
                   System.out.print(map[i][j] + " ");
               }
               System.out.println();
           }
           
           //使用递归回溯给小球找路
           //注意: 该方法中传入的map是引用类型, 所以递归时共享该数据, 因此递归时才会一起改变map的元素
           //setWay(map, 1, 1);
           setWay2(map, 1, 1);
           
           //输出新地图, 小球走过, 并标识过的递归
           System.out.println("小球走过, 并标识过的地图的情况");
           for(int i = 0; i < 8; i++) {
               for(int j = 0; j < 7; j++) {
                   System.out.print(map[i][j] + " ");
               }
               System.out.println();
           }
       }
       
       //使用递归回溯来给小球找路
       //说明:
       //1. map 表示地图
       //2. i,j 表示从地图的哪个位置开始出发(1,1)
       //3. 如果小球能到map[6][5]位置, 则说明通路找到
       //4. 约定: 当map[i][j]为0 表示该点没有走过;
       //                  当为1 表示墙;
       //                  当为2 表示通路可以走;
       //                  当为3 表示该点已经走过, 但是走不通;
       //5. 在走迷宫时, 需要确定一个策略(方法): 下->右->上->左, 如果该点走不通, 再回溯
       /**
        * @param map 表示地图
        * @param i,j 表示从哪个位置开始找
        * @return 如果找到通路, 就返回true, 否则返回false
        */
       public static boolean setWay(int[][] map, int i, int j) {
           if(map[6][5] == 2) { //通路已经找到ok
               return true;
           } else {
               if(map[i][j] == 0) { //如果当前这个点还没有走过
                   //按照策略: 下->右->上->左 走
                   map[i][j] = 2; //假定该点是可以走通
                   if(setWay(map, i+1, j)) { //向下走
                   	return true;
                   } else if(setWay(map, i, j+1)) { //向右走
                       return true;
                   } else if(setWay(map, i-1, j)) { //向上走
                   	return true;
                   } else if(setWay(map, i, j-1)) { //向左走
                       return true;
                   } else {
                       //说明该点是走不通的, 是死路
                       map[i][j] = 3;
                       return false;
                   }
               } else { //如果map[i][j] != 0, 可能是1, 2, 3
                   return false;
               }
           }
       }
       
       //修改找路的策略, 改成 上->右->下->左
       public static boolean setWay2(int[][] map, int i, int j) {
           if(map[6][5] == 2) { //通路已经找到ok
               return true;
           } else {
               if(map[i][j] == 0) { //如果当前这个点还没有走过
                   //按照策略: 上->右->下->左 走
                   map[i][j] = 2; //假定该点是可以走通
                   if(setWay2(map, i-1, j)) { //向上走
                   	return true;
                   } else if(setWay2(map, i, j+1)) { //向右走
                       return true;
                   } else if(setWay2(map, i+1, j)) { //向下走
                   	return true;
                   } else if(setWay2(map, i, j-1)) { //向左走
                       return true;
                   } else {
                       //说明该点是走不通的, 是死路
                       map[i][j] = 3;
                       return false;
                   }
               } else { //如果map[i][j] != 0, 可能是1, 2, 3
                   return false;
               }
           }
       }
   }
```

#### 3. 八皇后问题的分析和实现

1. **[递归 - 八皇后问题(回溯算法)]()** : 

   ![](D:\java数据结构-figure\39.png)

2. **[八皇后问题算法思路分析]()** :

   ![](D:\java数据结构-figure\40.png)

   * **思路** :
     1. 第一个皇后先放第一行第一列;
     2. 第二个皇后放在第二行第一列, 然后判断是否ok[即判断是否冲突], 如果不ok, 继续放在第二列, 第三列, 依次把所有列都放完, 找到一个合适;
     3. 继续第三个皇后, 还是第一列, 第二列...直到第八个皇后也能放在一个不冲突的位置, 算是找到了一个正确解;
     4. 当得到一个正确解时, 在栈回退到上一个栈时, 就会开始回溯, 即将第一个皇后, 放到第一列的所有正确解, 全部得到;
     5. 然后回头继续第一个皇后放第二列, 后面继续循环执行前面的步骤.
* **说明** : 理论上应该创建一个二维数组来表示棋盘, 但是实际上可以通过算法, 用一个**一维数组**即可解决问题. `arr[8] = {0, 4, 7, 5, 2, 6, 1, 3}` //**对应arr下标, 表示第几行, 即第几个皇后**, `arr[i] = val`, val表示第i+1个皇后, 放在第i+1行的第val+1列.
  
3. **[八皇后问题的代码实现]()** :

```java
   public class Queue8 {
       
       //定义一个max表示公有多少个皇后
       int max = 8;
       //定义数组array, 保存皇后位置的结果, 比如arr = {0, 4, 7, 5, 2, 6, 1, 3}
       int[] array = new int[max];
       static int count = 0;
       static int judgeCount = 0;
       
       public static void main(String[] args) {
       	//测试一把, 8皇后是否正确
           Queue8 queue8 = new Queue8();
           quque8.check(0);
           System.out.printf("一共有%d解法", count);
           System.out.printf("一共判断冲突的次数%d次", judgeCount);
       }
       
       //编写一个方法, 放置第n皇后
       //特别注意: check是每一次递归时, 进入到check中都有for(int i = 0; i < max; i++), 因此会有回溯
       private void check(int n) {
           if(n == max) { //n=8, 其实8个皇后就已然放好了, 同时如果一行已经全部遍历完, 则说明当前皇后在当前行已经没有位置可放了, 则回溯调用前面的皇后的位置, 所以这行代码有两层含义
               print();
               return;
           }
           
           //依次放入皇后, 并判断是否冲突
           for(int i = 0; i < max; i++) {
               //先把当前这个皇后n, 放到该行的第1列
               array[n] == i;
               //判断当放置第n个皇后到i列时, 是否冲突
               if(judge(n)) {
                   //接着放n+1个皇后
                   check(n+1);
               }
               //如果冲突, 就继续执行array[n]=i; 即将第n个皇后, 放置在本行的后移的一个位置
           }
       }
       
       //查看当放置第n个皇后, 就去检测该皇后是否和前面已经摆放的皇后冲突
       /**
        *
        * @param n 表示第n个皇后
        * @return
        */
       private boolean judge(int n) {
           judgeCount++;
           for(int i = 0; i < n; i++) {
               //说明
               //1. array[i] == array[n] 表示判断第n个皇后是否和前面的n-1个皇后在同一列
               //2. Math.abs(n-i) == Math.abs(array[n]-array[i]) 表示判断第n个皇后是否和第i个皇后在同一斜线
               //3. 判断是否在同一行, 没有必要, n每次都在递增
               if(array[n] == array[i] || Math.abs(n-i) == Math.abs(array[n] - array[i])) {
                   return false;
               }
           }
           return true;
       }
       
       //写一个方法, 可以将皇后摆放的位置输出
       private void print() {
           count++;
           for(int i = 0; i < array.length; i++) {
               System.out.print(array[i] + " ");
           }
           System.out.println();
       }
   }
```



## 排序算法

#### 1. 排序算法介绍和分类

* **排序算法的介绍**: 
    排序也称排序算法, 排序是将一组数据依指定的顺序进行排列的过程.
* **排序的分类**:
    1. ***内部排序***: 
        指将需要处理的所有数据都加载到<u>内部存储器(内存)</u>中进行排序.
    2. ***外部排序***:
        数据量过大, 无法全部加载到内存中, 需要借助<u>外部存储(文件等)</u>进行排序.
    3. ***常见的排序算法分类***:
    ![](D:\java数据结构-figure\41.png)

#### 2. 算法的时间复杂度

* **度量一个程序(算法)执行时间的两种方法**:
    1. ***事后统计的方法***:
        这种方法可行, 但是有两个问题: 一是要想对设计的算法的运行性能进行评测, 需要实际运行该程序; 二是所得时间的统计量依赖于计算机的硬件, 软件等环境因素, 这种方式, <u>要在同一台计算机的相同状态下运行才能比较哪个算法速度更快</u>.
    2. ***事前估算的方法***:
        通过分析某个算法的<u>时间复杂度</u>来判断哪个算法更优.

* **时间频度**:
    1. ***基本介绍***:
        时间频度: 一个算法花费的时间与算法中语句的执行次数成正比例, 哪个算法中语句执行次数多, 它花费时间就多. <u>一个算法中的语句执行次数称为语句频度或时间频度</u>. 记为`T(n)`.
    2. ***三个特点***:
        1. 常数项可以忽略;
        2. 低次项可以忽略;
        3. 系数可以忽略.

* **时间复杂度**:
    1. 一般情况下, 算法中的基本操作语句的重复执行次数是问题规模n的某个函数, 用T(n)表示, 若有某个辅助函数f(n), 使得当n趋近于无穷大时, T(n)/f(n)的极限值为不等于零的常数, 则称f(n)是T(n)的同数量级函数. 记作T(n)=O(f(n)), 称O(f(n))为算法的渐进时间复杂度, 简称时间复杂度.
    2. T(n)不同, 但时间复杂度可能相同.
    3. 计算时间复杂度的方法:
        * 用常数1代替运行时间中的所有加法常数
        * 修改后的运行次数函数中, 只保留最高阶项
        * 去除最高阶项的系数
    4. 常见的时间复杂度:
        1. 常数阶O(1): 无论代码执行了多少行, 只要是没有循环等复杂结构, 那这个代码的时间复杂度就都是O(1).
        2. 对数阶O(log_2 n):
        ![](D:\java数据结构-figure\42.png)
        3. 线性阶O(n): 单层循环.
        4. 线性对数阶O(nlog_2 n): 将时间复杂度为O(logn)的代码循环N遍的话, 那么它的时间复杂度就是`n*O(logN)`, 也就是O(nlogN).
        5. 平方阶O(n^2): 双层循环.
        6. 立方阶O(n^3)
        7. k次方阶O(n^k)
        8. 指数阶O(2^n)
    5. 注意:
        * 常见的算法时间复杂度由小到大依次为: O(1) < O(log_2 n) < O(n) < O(nlog_2 n) < O(n^2) < O(n^3) < O(n^k) < O(2^n). 随着问题规模n的不断增大, 上述时间复杂度不断增大, 算法的执行效率越低.
        * 要尽可能避免使用指数阶的算法.
    6. 平均时间复杂度和最坏时间复杂度
        1. 平均时间复杂度是指所有可能的输入实例均以等概率出现的情况下, 该算法的运行时间.
        2. 最坏情况下的时间复杂度称最坏时间复杂度. 一般讨论的时间复杂度均是最坏情况下的时间复杂度. 这样做的原因是: 最坏情况下的时间复杂度是算法在任何输入实例上运行时间的界限, 这就保证了算法的运行时间不会比最坏情况更长.
        3. 平均时间复杂度和最坏时间复杂度是否一致, 和算法有关.
        ![](D:\java数据结构-figure\43.png)

#### 3. 算法的空间复杂度

* **基本介绍:**
    1. 一个算法的空间复杂度定义为该算法所耗费的存储空间, 它也是问题规模n的函数.
    2. 空间复杂度是对一个算法在过程中临时占用存储空间大小的度量. 有的算法需要占用的临时工作单元数与解决问题的规模n有关, 它随着n的增大而增大, 当n较大时, 将占用较多的存储单元, 例如快速排序和归并排序算法就属于这种情况.
    3. 在做算法分析时, 主要讨论的是时间复杂度. 从用户使用体验上看, 更看重的是程序的执行的速度. 一些缓存产品和算法本质就是用空间换时间.

#### 4. 冒泡排序算法

1. **思路图解:**
    * 冒泡排序(Buffle Sorting)的基本思想: 通过对待排序序列从前向后(从下标较小的元素开始), 依次比较相邻元素的值, 若发现逆序则交换, 使值较大的元素逐渐从前移向后部, 就像水底下的气泡一样逐渐向上冒.
    * 总结冒泡排序规则:
        1. 如果***相邻的元素***逆序就交换.
        2. 一共进行***数组的大小-1***次的循环.
        3. 每一趟排序的次数在逐渐减少.
        4. 如果发现在某趟排序中, 没有发生一次交换, 可以提前结束冒泡排序(优化).
    * 注意: 因为排序的过程中, 各元素不断接近自己的位置, ***如果下一趟比较下来没有进行过交换, 就说明序列有序***, 因此要在排序过程中设置一个***标志flag***判断元素是否进行过交换. 从而减少不必要的比较.
2. **代码实现:**

	```java
	public class BubbleSort {
	
		public static void main(String[] args) {
			int[] arr = {3, 9, -1, 10, -2};
			
			//为了容易理解, 把冒泡排序的演变过程, 展示出来
			
			//时间复杂度为O(n^2)
			
			int temp = 0; //临时变量
			for(int i = 0; i < arr.length - 1; i++) { //一共有五个数，所以要进行四趟排序
				for(int j = 0; j < arr.length - 1 - i; j++) {
	                //如果前面的数比后面的数大， 则交换
	                if(arr[j] > arr[j + 1]) {
	                    temp = arr[j];
	                    arr[j] = arr[j + 1];
	                    arr[j + 1] = temp;
	                }
	            }
	            System.out.println("第"+ (i + 1) +"趟排序后的数组");
	            System.out.println(Arrays.toString(arr)); //将数组转换为字符串输出
			}
		}
	}
	```

3. **优化和总结:**
	
	```java
	public class BubbleSort {
	
		public static void main(String[] args) {
			//int[] arr = {3, 9, -1, 10, -2};
			
			//System.out.println("排序前")；
			//System.out.println(Arrays.toString(arr));
			
			//为了容易理解, 把冒泡排序的演变过程, 展示出来
			
			//测试一下冒泡排序的速度O(n^2)，给80000个数据，测试
			//创建要给80000个的随机的数组
			int[] arr = new int[80000];
			for(int i = 0; i < 80000; i++) {
				arr[i] = (int)(Math.random() * 8000000); //生成一个[0,8000000)数
			}
			
			Date date1 = new Date();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date1Str = SimpleDateFormat.format(date1);
			System.out.println("排序前的时间是=" + date1Str);
			
			//测试冒泡排序
			bubbleSort(arr);
			
			Date date2 = new Date();
			String date2Str = SimpleDateFormat.format(date2);
			System.out.println("排序后的时间是=" + date2Str);
			
			//System.out.println("排序后")；
			//System.out.println(Arrays.toString(arr)); //数组是引用类型
		}
		
		//将前面的冒泡排序算法，封装成一个方法
		public static void bubbleSort(int[] arr) {
			int temp = 0; //临时变量
			boolean flag = false; //标识变量，表示是否进行过交换
			for(int i = 0; i < arr.length - 1; i++) { //一共有五个数，所以要进行四趟排序
				for(int j = 0; j < arr.length - 1 - i; j++) {
	                //如果前面的数比后面的数大， 则交换
	                if(arr[j] > arr[j + 1]) {
	                    flag = true;
	                    temp = arr[j];
	                    arr[j] = arr[j + 1];
	                    arr[j + 1] = temp;
	                }
	            }
	            //System.out.println("第"+ (i + 1) +"趟排序后的数组");
	            //System.out.println(Arrays.toString(arr)); //将数组转换为字符串输出
	            
	            if(!flag) { //在一趟排序中，一次交换都没有发生过
	            	break;
	            } else {
	            	flag = false; //重置flag，进行下次判断
	            }
			}
		}
	}
	```

#### 5. 选择排序算法

1. **思路图解：**
    * ***基本介绍：***  
        * 选择式排序也属于内部排序法，是从欲排序的数据中，按指定的规则选出某一元素，再依规定交换位置后达到排序的目的。
    * ***选择排序思想：***  
        * 第一次从arr[0]~arr[n-1]中选择最小值，与arr[0]交换，第二次从arr[1]~arr[n-1]中选择最小值，与arr[1]交换，……。总共n-1次，得到一个按排序码从小到大排列的有序序列。
    * ***说明：***
        * 选择排序一共有数组大小-1轮排序
        * 每一轮排序，又是一个循环，循环的规则(代码)：
            1. 先假定当前这个数是最小数；
            2. 然后和后面的每个数进行比较，如果发现有比当前数更小的数，就重新确定最小数，并得到下标；
            3. 当遍历到数组的最后时，就得到本轮最小数和下标；
            4. 交换。
2. **代码实现：**
	```java
	public class SelectSort {
	
	    public static void main(String[] args) {
			int[] arr = {101, 34, 119, 1};
			System.out.println("排序前~");
			System.out.println(Arrays.toString(arr));
			selectSort(arr);

			System.out.println("排序后");
			System.out.println(Arrays.toString(arr));
		}
	
		//选择排序
		public static void selectSort(int[] arr) {

			//在推导的过程中, 发现了规律, 因此可以使用for循环来解决
			//选择排序的时间复杂度是O(n^2)			

			for(int i = 0; i < arr.length - 1; i++) {
				int minIndex = i;
				int min = arr[i];
				for(int j = i + 1; j < arr.length; j++) {
	            	if(arr[j] < min) { //说明假定的最小值, 并不是最小
						minIdex = j; //重置minIndex
						min = arr[j]; //重置min
					}
				}
				
				if(minIndex != i) {
					//将最小值放在arr[i], 即交换
					arr[minIndex] = arr[i];
					arr[i] = min;
				}
	
				System.out.println("第"+ (i + 1) +"轮后~");
				System.out.println("Arrays.toString(arr)");
			}

			/*
			//使用逐步推导的方式来讲解选择排序
			//算法: 先简单 --> 后复杂, 就是可以把一个复杂的算法, 拆分成简单的问题 --> 逐步解决
			
			//第1轮
			int minIndex = 0;
			int min = arr[0];
			for(int j = 0 + 1; j < arr.length; j++) {
            	if(arr[j] < min) { //说明假定的最小值, 并不是最小
					minIdex = j; //重置minIndex
					min = arr[j]; //重置min
				}
			}
			
			if(minIndex != 0) {
				//将最小值放在arr[0], 即交换
				arr[minIndex] = arr[0];
				arr[0] = min;
			}

			System.out.println("第1轮后~");
			System.out.println("Arrays.toString(arr)");

			//第2轮
			minIndex = 1;
			min = arr[1];
			for(int j = 1 + 1; j < arr.length; j++) {
            	if(arr[j] < min) { //说明假定的最小值, 并不是最小
					minIdex = j; //重置minIndex
					min = arr[j]; //重置min
				}
			}
			
			if(minIndex != 1) {
				//将最小值放在arr[1], 即交换
				arr[minIndex] = arr[1];
				arr[1] = min;
			}

			System.out.println("第2轮后~");
			System.out.println("Arrays.toString(arr)");
		}

		//第3轮, ...
		*/
        
	}
	```
3. **速度测试：**
	```java
	public class SelectSort {
	
	    public static void main(String[] args) {
			//int[] arr = {101, 34, 119, 1};

			//测试一下选择排序的速度O(n^2)，给80000个数据，测试. 在机器上是2-3秒, 比冒泡快.
			//创建要给80000个的随机的数组
			int[] arr = new int[80000];
			for(int i = 0; i < 80000; i++) {
				arr[i] = (int)(Math.random() * 8000000); //生成一个[0,8000000)数
			}
			
			//System.out.println("排序前~");
			//System.out.println(Arrays.toString(arr));

			Date date1 = new Date();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date1Str = SimpleDateFormat.format(date1);
			System.out.println("排序前的时间是=" + date1Str);
			
			selectSort(arr);

			Date date2 = new Date();
			String date2Str = SimpleDateFormat.format(date2);
			System.out.println("排序后的时间是=" + date2Str);			

			//System.out.println("排序后");
			//System.out.println(Arrays.toString(arr));
		}
	
		//选择排序
		public static void selectSort(int[] arr) {

			//在推导的过程中, 发现了规律, 因此可以使用for循环来解决
			//选择排序的时间复杂度是O(n^2)			

			for(int i = 0; i < arr.length - 1; i++) {
				int minIndex = i;
				int min = arr[i];
				for(int j = i + 1; j < arr.length; j++) {
	            	if(arr[j] < min) { //说明假定的最小值, 并不是最小
						minIdex = j; //重置minIndex
						min = arr[j]; //重置min
					}
				}
				
				if(minIndex != i) {
					//将最小值放在arr[i], 即交换
					arr[minIndex] = arr[i];
					arr[i] = min;
				}
	
				System.out.println("第"+ (i + 1) +"轮后~");
				System.out.println("Arrays.toString(arr)");
			}
		}
    }

	```

#### 6. 插入排序 ####

1. **思路图解:**
    * ***基本介绍:***
        * 插入式排序属于内部排序法, 是对欲排序的元素以插入的方式找寻该元素的适当位置, 已达到排序的目的.
    * ***基本思想:***
        * 把n个待排序的元素看成为一个有序表和一个无序表, <u>开始时有序表中只包含一个元素怒, 无序表中包含有n-1个元素</u>, 排序过程中每次从无序表中取出第一个元素, 把它的排序码依次与有序表元素的排序码进行比较, 将它插入到有序表中的适当位置, 使之成为新的有序表.
    * ***思路图:***
        * ![插入排序思路图](D:\java数据结构-figure\44.png "插入排序思路图")
    * ***存在的问题及解决办法:***
        * 存在的问题: 当需要插入的数是较小的数时, 后移的次数明显增多, 对效率有影响.
        * 解决办法: 使用希尔排序, 它是简单插入排序经过改进后的一个更高效的版本.
2. **代码实现:**
    ```java
	public class InsertSort {
		
		public static void main(String[] args) {
        	int[] arr = {101, 34, 119, 1};
			System.out.println("排序前~");
			System.out.println(Arrays.toString(arr));
			insertSort(arr);
			System.out.println("排序后~");
			System.out.println(Arrays.toString(arr));
		}
		
		//插入排序
		public static void insertSort(int[] arr) {
			
			//使用for循环来把代码简化
			for(int i = 1; i < arr.length; i++) {
				//定义待插入的数
				int insertVal = arr[i];
				int insertIndex = i - 1; //即arr[i]其那面的这个数的下标

				//给insertVal找到插入位置
				while(insertIndex >= 0 && insertVal < arr[insertIndex]) {
					arr[insertIndex + 1] = arr[insertIndex];
					insertIndex--; 
				}

				//当退出while循环时, 说明插入的位置找到了, insertIndex + 1
				arr[insertIndex + 1] = insertVal;
				System.out.println("第"+ i +"轮插入");
				System.out.println(Arrays.toString(arr));
			}
			
			/*
			//使用逐步推导的方式来讲解, 便于理解
			//第1轮
			
			//定义待插入的数
			int insertVal = arr[1];
			int insertIndex = 1 - 1; //即arr[1]的前面这个数的下标
			
			//给intsertVal找到插入的位置, 注意是倒着找
			//说明:
			//1. insertIndex >= 0 保证在给insertVal找插入位置时不越界
			//2. insertVal < arr[insertIndex] 待插入的数还没有找到插入位置
			//3. 需要将arr[insertIndex]后移
			while(insertIndex >= 0 && insertVal < arr[insertIndex]) {
				arr[insertIndex + 1] = arr[insertIndex]; //arr[insertIndex]后移
				//注意: 后移过程中不用管待插入的数, 因为已经保存了, 找到位置之后将待插入的数插入即可.
				insertIndex--;
			} 
			//当退出while循环时, 说明插入的位置找到, insertIndex + 1
			arr[insertIndex + 1] = insertVal;

			System.out.println("第1轮插入");
			System.out.println(Arrays.toString(arr));

			//第2轮
			insertVal = arr[2];
			insertIndex = 2 - 1;
			while(insertIndex >= 0 && insertVal < arr[indexIndex]) {
				arr[insertIndex + 1] = arr[insertIndex];
				insertIndex--;
			}

			arr[insertIndex + 1] = insertVal;

			System.out.println("第2轮插入");
			System.out.println(Arrays.toString(arr));

			//第3轮
			*/
			
		}
	}
    ```    
3. **速度测试:**
    ```java
	public class InsertSort {
		
		public static void main(String[] args) {
        	//int[] arr = {101, 34, 119, 1};
			
			int[] arr = new int[80000];
			for(int i = 0; i < 80000; i++) {
				arr[i] = (int)(Math.random() * 8000000); //生成一个[0,8000000)数
			}

			Date date1 = new Date();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date1Str = SimpleDateFormat.format(date1);
			System.out.println("排序前的时间是=" + date1Str);
			
			insertSort(arr); //调用插入排序算法

			Date date2 = new Date();
			String date2Str = SimpleDateFormat.format(date2);
			System.out.println("排序后的时间是=" + date2Str);	
		}
		
		//插入排序
		public static void insertSort(int[] arr) {
			
			//使用for循环来把代码简化
			for(int i = 1; i < arr.length; i++) {
				//定义待插入的数
				int insertVal = arr[i];
				int insertIndex = i - 1; //即arr[i]其那面的这个数的下标

				//给insertVal找到插入位置
				while(insertIndex >= 0 && insertVal < arr[insertIndex]) {
					arr[insertIndex + 1] = arr[insertIndex];
					insertIndex--; 
				}

				//当退出while循环时, 说明插入的位置找到了, insertIndex + 1
				if(insertIndex + 1 != i) {
					arr[insertIndex + 1] = insertVal;
				}
				//System.out.println("第"+ i +"轮插入");
				//System.out.println(Arrays.toString(arr));
			}
		}
	}
    ```

#### 6. 希尔排序 ####

1. **思路图解：**
    * ***基本介绍：***
        * 希尔排序是一种插入排序，它是简单插入排序经过改进之后的一个更高效的版本，也称为缩小增量排序。
    * ***基本思想：***
        * 希尔排序是把记录按下标的一定增量分组，对每组使用直接插入排序算法排序；随着增量逐渐减少，每组包含的关键词越来越多，当增量减至1时，整个文件恰被分成一组，算法便终止。
    * ***示意图：***
        * ![](D:\java数据结构-figure\45.png)
2. **代码实现：**
    1. 希尔排序时, 对有序序列在插入时采用交换法, 并测试排序速度.
        ```java
		public class shellSort {
			
			public static void main(String[] args) {
				int[] arr = {8, 9, 1, 7, 2, 3, 5, 4, 6, 0};
				shellSort(arr);
				
			}

			//使用逐步推导的方式来编写希尔排序
			//希尔排序时, 对有序序列在插入时采用交换法
			//思路(算法) ==> 代码
			public static void shellSort(int[] arr) {
				int temp = 0;
				int count = 0;
				//根据前面的逐步分析, 使用循环处理
				for(int gap = arr.length / 2; gap > 0; gap /= 2) {
					for(int i = gap; i < arr.length; i++) {
						//遍历各组中所有的元素(共gap组), 步长gap, 每组使用直接插入排序算法, 但是不是向后移位, 而是交换
						for(int j = i - gap; j >= 0; j -= gap) {
							//如果当前元素大于加上步长后的那个元素, 说明交换
							if(arr[j] > arr[j + gap]) {
								temp = arr[j];
								arr[j] = arr[j + gap];
								arr[j + gap] = temp;
							}
						}
					}
					System.out.println("希尔排序第"+ (++count) + "轮=" + Arrays.toString(arr));
				}

				/*
				//希尔排序的第1轮排序
				//因为第1轮排序是将10个数据分成了5组
				for(int i = 5; i < arr.length; i++) {
					//遍历各组中所有的元素(共5组, 每组有2个元素), 步长5, 每组使用直接插入排序算法, 但是不是向后移位, 而是交换
					for(int j = i - 5; j >= 0; j -= 5) {
						//如果当前元素大于加上步长后的那个元素, 说明交换
						if(arr[j] > arr[j + 5]) {
							temp = arr[j];
							arr[j] = arr[j + 5];
							arr[j + 5] = temp;
						}
					}
				}
				
				System.out.println("希尔排序1轮后=" + Arrays.toString(arr));

				//希尔排序的第2轮排序
				//因为第2轮排序是将10个数据分成了5/2=2组
				for(int i = 2; i < arr.length; i++) {
					//倒序遍历各组中所有的元素(共2组, 每组有5个元素), 步长5
					for(int j = i - 2; j >= 0; j -= 2) {
						//如果当前元素大于加上步长后的那个元素, 说明交换
						if(arr[j] > arr[j + 2]) {
							temp = arr[j];
							arr[j] = arr[j + 2];
							arr[j + 2] = temp;
						}
					}
				}
				
				System.out.println("希尔排序2轮后=" + Arrays.toString(arr));

				//因为第3轮排序是将10个数据分成了2/2=1组
				*/
			}
		}
		```
    2. 希尔排序时, 对有序序列在插入时采用移动法, 并测试排序速度.
3. **速度测试：** 