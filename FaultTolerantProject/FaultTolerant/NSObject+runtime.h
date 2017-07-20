//
//  NSObject+WDSafe.h
//
//

#import <Foundation/Foundation.h>

@interface NSObject(runtime)

/**
 交互实例方法

 @param originSelector 原有方法
 @param swizzledSelector 替换方法
 @return 是否替换成功
 */
+ (BOOL)swizzleOriginInstanceMethod:(SEL)originSelector
             swizzledInstanceMethod:(SEL)swizzledSelector;

@end
