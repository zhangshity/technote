# Java Reflection (Java反射机制)

                                                        --chunyang.zhang 
---

### 三种反射获取实例的方式
* 1)Class类静态方法`Class.forName("com.zcy.reflection.Person");`   --最常用
* 2)每个类继承的Object类的`person.getClass()`方法;                   --需要先实例化对象
* 3)对象实例`Class clazz = Person.class`                           --？


### 构造器获取方法
* Constructor constructor= clazz.getConstructor();  

### 实例化对象
* 1)Object obj  = clazz.newInstance();        
* 2)Object obj2 = constructor.newInstance();

### 获取对象方法
* Method method1 = obj.getMethod("setId",int.class);              --方法名,参数 获取
* Method method2 = obj.getDeclaredMethod("setId",int.class);      --强制获取,包括私有
* Method[] methods1 = obj.getMethods();                           --所有方法
* Method[] methods2 = obj.getDeclaredMethods();                   --强制获取所有方法

### 获取对象字段
* Field field1 = obj.getField("id");                              --字段名获取
* Field field2 = obj.getDeclaredField("id");                      --强制获取,包括私有
* Field[] fields1 = obj.getFields();                              --所有字段
* Field[] fields2 = obj.getDeclaredFields();                      --强制获取所有字段








#### ======分割线(测试用的类)===================================================

##### 实体类Entity

public class Person {

    private int id;
    private String name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}