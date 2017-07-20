# FaultTolerant
防止崩溃的runtime策略（NSArray、NSDictionary、NSString）


##1、目的
在使用NSArray（NSMutableArray）、NSString（NSMutableString）、NSDictionary（NSMutableDictionary）的操作时，避免因为数组越界、空值nil（如：服务端返回值异常）等造成的线上崩溃。
我们希望防止的是线上的崩溃（但要知道是否防止了崩溃、以及崩溃的具体信息），而在开发期间能正常暴露代码的问题、修复逻辑的不严谨性。

##2、策略
对于系统方法出现越界、插入空值等运行时候才能发现的问题，我们可以通过runtime的method swizzling进行全局的处理，给系统方法添加我们的容错处理（重要：最后还是要调用系统的方法）。
针对线上环境与开发环境，可以使用全局变量来区分。
（线上）崩溃信息，可以使用bugly来统计错误的堆栈信息。
![GitHub](https://github.com/Jacue/FaultTolerant/blob/master/61A8FD7A-3DD3-4EA5-B884-91F45B81AB04.png?raw=true)

##3、崩溃原因

类簇（以数组为例）
NSArray／NSMutableArray
__NSPlaceholderArray alloc方法创建的工厂类
__NSArray0 空数组
__NSSingleObjectArrayI 一个元素的数组
__NSArrayI 有多个元素的数组
__NSArrayM 可变数组

初始化：[__NSPlaceholderArray initWithObjects:count:]
简便初始化方法、实例初始化方法、类初始化方法均会调用该方法
```
增删改查：
insertObject:atIndex:             增
setObject:atIndexedSubscript:     改
removeObjectAtIndex:              删
replaceObjectAtIndex:withObject:  改
objectAtIndex                     查
```

##4、注意事项
* Method swizzling 是非原子性的，在多线程环境下可能被多次修改，但同样 Method swizzling 又是全局性的，就会造成不可预知的错误。
* 可能出现命名冲突的问题，这样就不会调用到系统原方法，可能导致未知问题。
* Method swizzling 看起来像递归，对新人来说不容易理解。
* 出现问题 Method swizzling 不容易进行debug，来发现问题
* 随着项目迭代和人员更换，使用Method swizzling 的项目不容易维护，因为开发人员有时根本不知道在Method swizzling 里面修改了东西。
* Method swizzling会hook系统的方法

对于runtime唯一的建议就是，需谨慎使用，一旦使用，必须先了解runtime的相关原理，做好预防措施，在添加完自己的代码之后，一定要调用系统原来的方法。




