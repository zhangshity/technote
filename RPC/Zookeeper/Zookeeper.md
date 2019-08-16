# Zookeeper

@Author:Chun Yang . Zhang

---

![zookeeper](https://github.com/zhangshity/technote/blob/master/Resources/zookeeper.png)

* 集群角色
  1. Leader
  2. Follower
  3. Observer

版本控制

​		悲观锁(排他性，独占资源直到释放，其他人才能访问)，乐观锁(都可以访问，加入版本控制，更新时比对版本号)

​			

ACL权限控制(Access Control Lists)   

​		CREATE 创建子节点

​		READ 获取节点数据和子节点列表

​		WRITE 更新数据节点

​		DELETE 删除子节点

​		ADMIN 设置节点ACL的权限

