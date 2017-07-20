//
//  NSArray+WDSafe.m
//
//
//

#import "NSArray+runtime.h"
#import <objc/runtime.h>
#import "NSObject+runtime.h"

@interface NSArray(WDSafe)

@end

@implementation NSArray(WDSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
            //objectAtIndex 包括objectAtIndex和字面量temp[i]方法替换
            [objc_getClass("__NSArray0") swizzleOriginInstanceMethod:@selector(objectAtIndex:)
                                              swizzledInstanceMethod:@selector(safe_objectAtIndex:)];
            
            [objc_getClass("__NSSingleObjectArrayI") swizzleOriginInstanceMethod:@selector(objectAtIndex:)
                                                          swizzledInstanceMethod:@selector(safe_objectAtIndex:)];
            
            [objc_getClass("__NSArrayI") swizzleOriginInstanceMethod:@selector(objectAtIndex:)
                                              swizzledInstanceMethod:@selector(safe_objectAtIndex:)];
            
            // 初始化容错
            [objc_getClass("__NSPlaceholderArray") swizzleOriginInstanceMethod:@selector(initWithObjects:count:)
                                                        swizzledInstanceMethod:@selector(safe_initWithObjects:count:)];

            // 可变数组(增删改查)
            [objc_getClass("__NSArrayM") swizzleOriginInstanceMethod:@selector(objectAtIndex:)
                                              swizzledInstanceMethod:@selector(safe_objectAtIndex:)];
            
            [objc_getClass("__NSArrayM") swizzleOriginInstanceMethod:@selector(replaceObjectAtIndex:withObject:)
                                              swizzledInstanceMethod:@selector(safe_replaceObjectAtIndex:withObject:)];
            [objc_getClass("__NSArrayM") swizzleOriginInstanceMethod:@selector(setObject:atIndexedSubscript:)
                                              swizzledInstanceMethod:@selector(safe_setObject:atIndexedSubscript:)];
            [objc_getClass("__NSArrayM") swizzleOriginInstanceMethod:@selector(insertObject:atIndex:)
                                              swizzledInstanceMethod:@selector(safe_insertObject:atIndex:)];
            [objc_getClass("__NSArrayM") swizzleOriginInstanceMethod:@selector(removeObjectAtIndex:)
                                              swizzledInstanceMethod:@selector(safe_removeObjectAtIndex:)];
        }
    });
}


/**
    查
 */
- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index < self.count ) {
        return [self safe_objectAtIndex:index];
    }
    return nil;//越界返回为nil
}

/**
    初始化
 */
- (instancetype)safe_initWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id validObjects[cnt];
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < cnt; i++){
        if (objects[i]){
            validObjects[count] = objects[i];
            count++;
        }
    }
    
    return [self safe_initWithObjects:validObjects count:count];
}

/**
    改
 */
- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= self.count){
        return;
    }
    
    if (!anObject){
        return;
    }
    
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

/**
    增
 */
- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > self.count){
        return;
    }
    
    if (!anObject){
        return;
    }
    
    [self safe_insertObject:anObject atIndex:index];
}


/**
    改
 */
- (void)safe_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {
    
    if (index > self.count){
        return;
    }
    
    if (!anObject){
        return;
    }
    
    [self safe_setObject:anObject atIndexedSubscript:index];
}

/**
    删
 */
- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    
    if (index < self.count ) {
        return [self safe_removeObjectAtIndex:index];
    }
    return;//越界返回为nil
}




@end
