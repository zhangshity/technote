>  看什么都不如看官方源码描述，只不过描述的有点拗口就是了，真TMSB，大长从句一堆一堆的，不能拆的好理解点吗。英语很重要- -! 翻译真费劲 0.0
>

#####@Author: ChunYang.Zhang

```java
/**
 * Serializability of a class is enabled by the class implementing the
 * java.io.Serializable interface. Classes that do not implement this
 * interface will not have any of their state serialized or
 * deserialized.  All subtypes of a serializable class are themselves
 * serializable.  The serialization interface has no methods or fields
 * and serves only to identify the semantics of being serializable. <p>
 *
类的序列化可以通过实现java.io.Serializable接口开启。
没有继承此接口的类不会有任何状态的序列化和反序列化。
可序列化的类的所有子类型本身是可序列化的。
序列化接口没有字段和方法，其作用只是为了定义可序列化的语法。
 
 * To allow subtypes of non-serializable classes to be serialized, the
 * subtype may assume responsibility for saving and restoring the
 * state of the supertype's public, protected, and (if accessible)
 * package fields.  The subtype may assume this responsibility only if
 * the class it extends has an accessible no-arg constructor to
 * initialize the class's state.  It is an error to declare a class
 * Serializable if this is not the case.  The error will be detected at
 * runtime. <p>
 *
为了允许不能序列化的子类型能被序列化，子类型可能承担存储和恢复父类型的public,protected和(如果可行)package字段 状态的责任。
只有此类继承了 有可用的无参构造器来初始化类的状态时，子类型才可能承担此责任。
如果情况并非如此，那可能这是一个错误的声明可序列化类的方式。这个错误将会在运行时被检测到。
 
 * During deserialization, the fields of non-serializable classes will
 * be initialized using the public or protected no-arg constructor of
 * the class.  A no-arg constructor must be accessible to the subclass
 * that is serializable.  The fields of serializable subclasses will
 * be restored from the stream. <p>
 *
 在反序列化时，不能序列化类的字段将通过使用该类的public或protected无参构造器来初始化。一个无参构造器一定是可以被可序列化子类访问到的。可序列化的子类的字段将会在流中被恢复。
 
 * When traversing a graph, an object may be encountered that does not
 * support the Serializable interface. In this case the
 * NotSerializableException will be thrown and will identify the class
 * of the non-serializable object. <p>
 *
 当遍历图表时，一个Object可能会遭遇不支持序列化接口的情况。在这种情况下，NotSerializableException异常会被抛出，且将会定义这个Object为不能序列化的Object
 
 * Classes that require special handling during the serialization and
 * deserialization process must implement special methods with these exact
 * signatures:
 *
 在序列化和反序列化处理过程中，有特殊操作要求的类必须实现这些有额外签名的特殊方法：
 * <PRE>
 * private void writeObject(java.io.ObjectOutputStream out)
 *     throws IOException
 * private void readObject(java.io.ObjectInputStream in)
 *     throws IOException, ClassNotFoundException;
 * private void readObjectNoData()
 *     throws ObjectStreamException;
 * </PRE>
 *
 * <p>The writeObject method is responsible for writing the state of the
 * object for its particular class so that the corresponding
 * readObject method can restore it.  The default mechanism for saving
 * the Object's fields can be invoked by calling
 * out.defaultWriteObject. The method does not need to concern
 * itself with the state belonging to its superclasses or subclasses.
 * State is saved by writing the individual fields to the
 * ObjectOutputStream using the writeObject method or by using the
 * methods for primitive data types supported by DataOutput.
 *
 writeObject方法负责为特定的类编写状态，以便相应的readObject方法可以恢复它。保存Object字段的默认机制，可以通过调用out.defaultWriteObject方法来实现。 该方法不需要关注属于其父类或子类的状态。通过使用writeObject方法或使用DataOutput支持的原始数据类型的方法将各个字段写入ObjectOutputStream来保存State。
 
 * <p>The readObject method is responsible for reading from the stream and
 * restoring the classes fields. It may call in.defaultReadObject to invoke
 * the default mechanism for restoring the object's non-static and
 * non-transient fields.  The defaultReadObject method uses information in
 * the stream to assign the fields of the object saved in the stream with the
 * correspondingly named fields in the current object.  This handles the case
 * when the class has evolved to add new fields. The method does not need to
 * concern itself with the state belonging to its superclasses or subclasses.
 * State is saved by writing the individual fields to the
 * ObjectOutputStream using the writeObject method or by using the
 * methods for primitive data types supported by DataOutput.
 *
 readObject方法负责从流中读取并恢复类字段。 它可以调用in.defaultReadObject来调用恢复对象的非静态和非瞬态字段的默认机制。 defaultReadObject方法使用流中的信息来指定流中保存的对象的字段以及当前对象中相应命名的字段。 这处理了类在演变为添加新字段时的情况。 该方法不需要关注属于其超类或子类的状态。通过使用writeObject方法或使用DataOutput支持的原始数据类型的方法将各个字段写入ObjectOutputStream来保存State。
 
 * <p>The readObjectNoData method is responsible for initializing the state of
 * the object for its particular class in the event that the serialization
 * stream does not list the given class as a superclass of the object being
 * deserialized.  This may occur in cases where the receiving party uses a
 * different version of the deserialized instance's class than the sending
 * party, and the receiver's version extends classes that are not extended by
 * the sender's version.  This may also occur if the serialization stream has
 * been tampered; hence, readObjectNoData is useful for initializing
 * deserialized objects properly despite a "hostile" or incomplete source
 * stream.
 *
 readObjectNoData方法负责在序列化流未将给定类列为要反序列化的对象的超类的情况下初始化其特定类的对象的状态。 如果接收方使用与发送方不同版本的反序列化实例的类，并且接收方的版本扩展了未由发送方版本扩展的类，则可能发生这种情况。 如果序列化流已被篡改，也可能发生这种情况; 因此，尽管存在“恶意”或不完整的源流，readObjectNoData仍可用于正确初始化反序列化对象。
 
 * <p>Serializable classes that need to designate an alternative object to be
 * used when writing an object to the stream should implement this
 * special method with the exact signature:
 *
 需要指定在将对象写入流时使用的备用对象的可序列化类应该使用确切的签名实现此特殊方法：
 
 * <PRE>
 * ANY-ACCESS-MODIFIER Object writeReplace() throws ObjectStreamException;
 * </PRE><p>
 *
 * This writeReplace method is invoked by serialization if the method
 * exists and it would be accessible from a method defined within the
 * class of the object being serialized. Thus, the method can have private,
 * protected and package-private access. Subclass access to this method
 * follows java accessibility rules. <p>
 *
 如果方法存在，则可以通过序列化调用此writeReplace方法，并且可以从要序列化的对象的类中定义的方法访问该方法。 因此，该方法可以具有私有，受保护和包私有访问。 对此方法的子类访问遵循java可访问性规则。
 
 * Classes that need to designate a replacement when an instance of it
 * is read from the stream should implement this special method with the
 * exact signature.
 *
 从流中读取实例时需要指定替换的类应该使用精确签名实现此特殊方法。
 
 * <PRE>
 * ANY-ACCESS-MODIFIER Object readResolve() throws ObjectStreamException;
 * </PRE><p>
 *
 * This readResolve method follows the same invocation rules and
 * accessibility rules as writeReplace.<p>
 *
 此readResolve方法遵循与writeReplace相同的调用规则和可访问性规则。
 
 * The serialization runtime associates with each serializable class a version
 * number, called a serialVersionUID, which is used during deserialization to
 * verify that the sender and receiver of a serialized object have loaded
 * classes for that object that are compatible with respect to serialization.
 * If the receiver has loaded a class for the object that has a different
 * serialVersionUID than that of the corresponding sender's class, then
 * deserialization will result in an {@link InvalidClassException}.  A
 * serializable class can declare its own serialVersionUID explicitly by
 * declaring a field named <code>"serialVersionUID"</code> that must be static,
 * final, and of type <code>long</code>:
 *
 “序列化”运行时，通过一个版本号与每一个可序列化类建立联系，此版本号称为serialVersionUID，其在反序列化期间使用，用来验证 已加载类的可实例化对象的 发送者和接收者，是否兼容。
 (Google Translate:序列化运行时，将每个可序列化类通过一个版本号联系起来，其称为serialVersionUID，在反序列化期间，使用该版本号来验证序列化对象的发送方和接收方是否已加载与该序列化兼容的该对象的类。)
 
 如果接收者已为该对象加载了一个类，该类具有与相应发送者类不同的serialVersionUID，然后反序列化将导致{@link InvalidClassException}。 
 一个可序列化类可以显式声明它自己的serialVersionUID,通过声明一个叫"serialVersionUID"的字段，其必须是static,final且类型为long的。
 
 * <PRE>
 * ANY-ACCESS-MODIFIER static final long serialVersionUID = 42L;
 * </PRE>
 *
 * If a serializable class does not explicitly declare a serialVersionUID, then
 * the serialization runtime will calculate a default serialVersionUID value
 * for that class based on various aspects of the class, as described in the
 * Java(TM) Object Serialization Specification.  However, it is <em>strongly
 * recommended</em> that all serializable classes explicitly declare
 * serialVersionUID values, since the default serialVersionUID computation is
 * highly sensitive to class details that may vary depending on compiler
 * implementations, and can thus result in unexpected
 * <code>InvalidClassException</code>s during deserialization.  Therefore, to
 * guarantee a consistent serialVersionUID value across different java compiler
 * implementations, a serializable class must declare an explicit
 * serialVersionUID value.  It is also strongly advised that explicit
 * serialVersionUID declarations use the <code>private</code> modifier where
 * possible, since such declarations apply only to the immediately declaring
 * class--serialVersionUID fields are not useful as inherited members. Array
 * classes cannot declare an explicit serialVersionUID, so they always have
 * the default computed value, but the requirement for matching
 * serialVersionUID values is waived for array classes.
  *
  如果一个可序列化类没有显式声明一个serialVersionUID，那么序列化运行时，将会根据此类的各个方面为该类计算一个默认的serialVersionUID值，就像在Java(TM) Object Serialization Specification（Java对象序列化说明）中描述的那样。然而，这是一个strongly recommended(强烈推荐)的写法，所有的可序列化类都显式声明serialVersionUID的值，因为默认的serialVersionUID的计算是高度敏感易受类的细节影响的，这可能会广泛依赖编译器实现，且会因此导致不期待的结果。
  
 * @author  unascribed
 * @see java.io.ObjectOutputStream
 * @see java.io.ObjectInputStream
 * @see java.io.ObjectOutput
 * @see java.io.ObjectInput
 * @see java.io.Externalizable
 * @since   JDK1.1
 */
public interface Serializable {
}
```