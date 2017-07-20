//
//  NSObject+WDSafe.m
//
//

#import "NSObject+runtime.h"

#import <objc/runtime.h>

@implementation NSObject(runtime)

+ (BOOL)swizzleOriginInstanceMethod:(SEL)originSelector
             swizzledInstanceMethod:(SEL)swizzledSelector{
    Method originMethod = class_getInstanceMethod(self, originSelector);
    if (!originMethod) {
        return NO;
    }
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        return NO;
    }
    
    class_addMethod(self, originSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    class_addMethod(self, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originSelector), class_getInstanceMethod(self, swizzledSelector));
    return YES;
}

@end
