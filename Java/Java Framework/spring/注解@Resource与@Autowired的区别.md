# 注解@Resource与@Autowired的区别

> Spring容器以name为key储存bean！这里的name可以指定，否则取首字母小写的类名。有相同的就报异常：BeanDefinitionStoreException！

#### @Resource
>  @Resource有两个常用属性name、type，所以分4种情况
>
> 1. 指定name和type：通过name找到唯一的bean，找不到抛出异常；如果type和字段类型不一致，也会抛出异常
> 2. 指定name：通过name找到唯一的bean，找不到抛出异常
> 3. 指定type：通过tpye找到唯一的bean，如果不唯一，则抛出异常：NoUniqueBeanDefinitionException
> 4. 都不指定：通过字段名作为key去查找，找到则赋值；找不到则再通过字段类型去查找，如果不唯一，则抛出异常：NoUniqueBeanDefinitionException



#### @Autowired

> 1. @Autowired只有一个属性required，默认值为true，为true时，找不到就抛异常，为false时，找不到就赋值为null
> 2. @Autowired按类型查找，如果该类型的bean不唯一，则抛出异常；可通过组合注解解决
> 3. `@Autowired()@Qualifier("baseDao")`

---

* 相同点

  > Spring都支持
  > 都可以作用在字段和setter方法上

* 不同点

  > 1. 提供方：@Autowired是由org.springframework.beans.factory.annotation.Autowired提供，换句话说就是由Spring提供；@Resource是由javax.annotation.Resource提供，即J2EE提供，需要JDK1.6及以上。
  >
  > 2. 注入方式：@Autowired只按照byType 注入；@Resource默认按byName自动注入，也提供按照byType 注入；
  >
  > 3. 属性：Resource不允许找不到bean的情况，而Autowired允许（@Autowired(required = false)）
  >    指定name的方式不一样，@Resource(name = "baseDao"),@Autowired()@Qualifier("baseDao")
  >    Resource默认通过name查找，而Autowired默认通过type查找
  >
  >    

  

  