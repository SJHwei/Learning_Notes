## Linux实用指令: 文件目录类

* **[pwd]()** : 显示当前工作目录的绝对路径.

* **[ls -al 目录或文件]()** : 以列表方式显示指定的目录或文件.

* **[cd ~ / cd]()** : 回到自己的家目录.

* **[cd ..]()** : 回到上级目录.

  

* **[mkdir -p 目录]()** : 创建多级空目录. 

* **[rmdir -p 目录 ]()**: 删除多级空目录. 

* **[touch 文件 ]()**: 创建文件(可以一次性创建多个文件).

* **[rm -rf 目录]()** : 删除目录(该目录可以为空也可以不为空).

* **[rm 文件]()**  : 删除文件.

  

* **[mv oldnamefile newnamefile]()** : 对文件进行重命名.

*  **[mv 文件 目录]()** : 移动指定文件到指定目录下.

* **[cp 被拷贝文件 拷贝到的地方]()**: 拷贝文件到指定目录. 

* **[cp -r 被拷贝目录 拷贝到的地方]()** : 拷贝指定目录到指定文件夹.

* **[\cp]()** : 重复拷贝时, 强制覆盖不提示.

  

* **[cat -n 文件]()**: 一次性查看全部文件内容. 

* **[cat -n 文件 | more]()** : 分页查看文件内容.

* **[more 文件]()** :  以全屏幕的方式按页显示文本文件的内容.

* **[less 文件]()** : 用来分屏查看文件内容, 对于显示大型文件具有较高的效率.

  

* **[ls -l > 文件]()** : 列表中的内容写入文件中(覆盖写).

* **[ls -al >> 文件]()** : 列表中的内容追加到文件末尾.

* **[cat 文件1 > 文件2]()** : 将文件1的内容覆盖到文件2.

* **[echo "内容" >>文件]()** : 将内容直接追加写入文件中.

  

* **[echo  "内容"]()** : 输出内容到控制台.

* **[echo $PATH]()** : 输出环境变量.

* **[head 文件 ]()**: 显示该文件头10行内容.

* **[head -n 5 文件]()** : 显示该文件头5行内容.

* **[tail 文件]()** : 显示该文件尾部10行内容.

* **[tail -n 5 文件]()** : 显示该文件尾部5行内容.

* **[tail -f 文件]()** : 实时追踪该文档的所有更新, 按ctrl+c退出.

  

* **[In -s [原文件目录] [软链接名]]()** : 给原文件创建了一个软链接.

* **[rm -rf 软链接名]()** : 删除软链接, 而不删除该软链接所链接的目录(不带`/`). 

  

* **[history]()** : 显示全部

* **[history 10]()** : 显示10个

* **[!历史指令编号]()** : 执行指定的历史指令.



## Linux安装软件: RPM

* **[rpm -qa]()**: 查询全部rpm包
* **[rpm -qa | more]()**: 分页查看全部rpm包
* **[rpm -qa | grep X]()**: 查看特定的rpm包



* **[rpm -q X]()**: 查询特定的rpm包是否安装



* **[rpm -qi X]()**: 查询特定的rpm包的信息



* **[rpm -ql X]()**: 查看特定的rpm包中的文件



* **[rpm -qf 文件路径名]()**: 查询文件所属的rpm包



* **[rpm -e X]()**: 卸载rpm包

* **[rpm -e --nodeps X]()**: 强制卸载rpm包

  

* **[rpm -ivh X]()**: 安装rpm包



## Linux安装软件: YUM

* **[yum list | grep X]()**: 查询yum服务器是否有我需要安装的软件
* **[yum install XXX]()**: 安装指定的yum包



## Linux进程管理

* **[ps]()** : 查看系统中的进程信息

* **[ps -aux]()** : 查看系统中的进程的详细信息

* **[ps -aux | grep xxx]()** : 查看特定的进程的信息

* **[ps -ef]()** : 查看系统中所有进程的父进程

* **[ps -ef | grep xxx]()** : 查看特定进程的父进程

  

* **[kill 进程号]()** : 通过进程号杀死进程(有些进程不一定能杀死)

* **[kill -9 进程号]()** : 通过进程号强制杀死进程

* **[killall]()** : 杀死所有进程

* **[killall 进程名称]()** : 通过进程名称杀死进程

  

* **[pstree]()** : 查看进程树

* **[pstree -p]()** : 查看进程树(显示进程的PID)

* **[pstree -u]()** : 查看进程树(显示进程的所属用户)

* **[ps -pu]()**



## Linux防火墙服务的相关命令

* **[firewall-cmd --state]()** : 查看firewall的状态
* **[systemctl status firewalld]()** : 查看firewall服务状态
* **[systemctl start firewalld]()** : 开启防火墙服务
* **[systemctl restart firewalld]()** : 重启防火墙服务
* **[systemctl stop firewalld]()** : 关闭防火墙服务



## Linux服务管理

* **[systemctl  [start/stop/restart/reload/status  服务名]]()** : 临时作用

* **[chkconfig]()** : 长久作用

* **[chkconfig --list | grep xxx]()** : 查看特定服务

* **[chkconfig  服务名  --list]()** : 查看特定服务

* **[chkconfig  --level  5  服务名  on/off]()** : 修改某个服务在某个级别下是否自动启动

  

* **[setup -> 系统服务]()** : 可以查看服务名

* **[/etc/init.d/服务名称]()** : 查看服务名

* **[vi /etc/inittab]()** : 查看或修改默认的系统服务运行级别

`注意` : 查看服务有四种方式: systemctl, chkconfig, setup, /etc/init.d/  .

`注意` : 修改服务有两种方式: systemctl(临时作用), chkconfig(长久作用).



## Linux网络配置

* **[ipconfig]()** : 查看Linux的网络配置
* **[ifconfig]()** : 查看Windows的网络配置
* **[ping 目的主机]()** : 测试当前服务器是否可以连接目的主机



## Linux磁盘分区

* **[lsblk -f]()** : 查看当前系统的分区和挂载情况

* **[fdisk /dev/添加的新磁盘]()** : 对新磁盘进行分区

* **[mkfs -t ext4 /dev/sdb1]()** : 格式化磁盘

* **[mount 设备名称 挂载目录]()** : 挂载

* **[umount 设备名称/挂载目录]()** : 卸载

  

* **[df -lh]()** : 查询系统整体磁盘实用情况

* **[du -acsh --max-depth=1 /目录]()** : 查询指定目录的磁盘占用情况

* **[ls -l /目录 | grep "^-" | wc -l]()** : 统计指定目录下文件个数(加-r包括子目录)

* **[ls -l /目录 | grep "^d" | wc -l]()** : 统计指定目录下目录个数(加-r包括子目录)

  

* **[tree]()** : 以树状显示目录结构



## Linux任务调度

* **[crontab -e]()** : 编辑crontab定时任务
* **[crontab -l]()** : 查询crontab任务
* **[crontab -r]()** : 删除当前用户所有的crontab任务



## Linux用户管理, 组管理和权限管理

* **[useradd 用户名]()** : 添加用户

* **[useradd -d 指定目录 新用户名]()** : 添加用户到指定家目录中

* **[passwd 用户名]()** : 给指定用户指定或修改密码

* **[userdel 用户名]()** : 删除用户(保留家目录)

* **[userdel -r 用户名]()** : 删除用户(同时删除家目录)

* **[id 用户名]()** : 查询用户信息

* **[su 切换用户名]()** : 切换用户名

* **[whoami / who am i]()** : 查看当前用户/登录用户

  

* **[groupadd 组名]()** : 增加组

* **[groupdel 组名]()** : 删除组

  

* **[useradd -g 用户组 用户名]()** : 添加用户的同时指定组

* **[usermod -g 用户组 用户名]()** : 修改用户的所在组

* **[usermod -d 目录名 用户名]()** : 修改用户的家目录

  

* **[ls -ahl 目录/文件]()** : 查看指定目录或文件的所有者, 所在组和拥有的权限

* **[chown 用户名 文件/目录]()** : 修改文件或目录的所有者

* **[chown 用户名:所在组 文件/目录]()** : 修改文件/目录的所有者和所在组

* **[chown -R  用户名 目录]()** : 递归修改目录以及该目录下的所有子文件和子目录的所有者

* **[chgrp 所在组 文件/目录]()** : 修改文件或目录的所在组

  

* **[chmod u=rwx,g=rx,o=x 文件/目录]()** : 修改目录或文件的权限

* **[chmod 754 文件/目录]()** : 通过数字修改目录或文件的权限



**总结1** : 主要分为两类, 一类针对用户; 另一类针对文件/目录. 

**总结2** : 用户有所在组和家目录. 有对用户的各种操作, 有对组的各种操作, 还有对用户和组关联起来的操作, 还有对用户和家目录关联起来的操作.

**总结3** : 文件/目录有所有者(用户), 所在组. 有对文件的各种操作, 有对文件和所有者关联起来的各种操作, 有对文件和所在组关联起来的各种操作, 有对文件, 所有者和所在组关联起来的各种操作, 还有对文件/目录的所有者, 所在组和其他组用户的权限操作.



## Linux实用指令: 搜索查找类

* **[find /home -name hello.txt]()** : 从home目录向下递归遍历各个子目录, 看是否有hello.txt文件

* **[find /home -user sjhwei]()** : 从home目录向下递归遍历各个子目录, 看是否有sjhwei用户的文件

* **[find /home -size +20k]()** : 从home目录向下递归遍历各个子目录, 看是否有大于20k的文件

* **[find /home -size -20k]()** : 从home目录向下递归遍历各个子目录, 看是否有小于20k的文件

* **[find /home -size 20M]()** : 从home目录向下递归遍历各个子目录, 看是否有等于20M的文件

  

* **[update]()** : 创建或更新locate数据库.

* **[locate hello.txt]()** : 在数据库中查找hello.txt文件.

  

* **[cat hello.txt | grep -n yes]()** : 在hello.txt文件中找yes所在行并且显示所在行号

* **[cat hello.txt | grep -i yes]()** : 在hello.txt文件中找yes(忽略大小写)



* **总结** : find用来找文件; locate可以快速定位文件路径; grep用来在文件中查找想要的内容, 并且常和其他指令结合使用.



## Linux实用指令: 压缩和解压类

* **[gzip 文件]()** : 压缩文件, 格式为 .gz, 可以同时压缩多个

* **[gunzip 文件]()** : 解压文件, 格式为 .gz, 可以同时解压多个

  

* **[zip -r xxx.zip 文件/目录]()** : 打包压缩文件/目录

* **[unzip -d 目录路径 xxx.zip]()** : 解压到指定目录

  

* **[tar -zcvf xxx.tar.gz 文件/目录]()** : 压缩文件/目录

* **[tar -zxvf xxx.tar.gz -C 目录路径]()** : 解压到指定目录



**总结** : gzip/gunzip用于文件, 格式为 .gz; zip/unzip用于文件或目录, 格式为 .zip; tar用于文件/目录, 格式为 .tar.gz .



## Linux实用指令: 帮助类

* **[man  [命令或配置文件]]()**
* **[help  shell内置命令]()**

* **[百度]()**



## Linux实用指令: 时间日期类

* **[date]()** : 显示当前时间

* **[date  +%Y/%m/%d]()** : 显示年或月或秒

* **[date "+%Y-%m-%d %H : %M : %S"]()** : 显示年月日时分秒

  

* **[date -s 字符串时间]()** : 修改时间

  

* **[cal  [选项]]()** : 显示选项的日历. 不加选项, 显示本月日历.



## Linux系统下查看显卡信息(Nvidia显卡)

* **[lspci | grep -i vga]()** : 查看显卡信息.
* **[nvidia-smi]()** : 查看gpu占用静态信息
* **[nvidia-smi -l 10 / watch -n 10 nvidia-smi]()** : 每隔10秒更新gpu信息, 查看gpu占用动态信息
  * 第一列 : gpu编号, gpu的风扇转速;
  * 第二列 : 型号, 温度;
  * 第三列 : 性能状态;
  * 第四列 : 持续模式的状态, 能耗;
  * 第五列 : gpu总线;
  * 第六列 : gpu的显示是否初始化, 显存使用率;
  * 第七列 : 浮动的gpu利用率;
  * 第八列 : 错误检查和纠正, 计算模式.