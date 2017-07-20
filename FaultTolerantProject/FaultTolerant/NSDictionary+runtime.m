//
//  NSDictionary+runtime.m
//
//

#import "NSDictionary+runtime.h"
#import <objc/runtime.h>
#import "NSObject+runtime.h"

@interface NSDictionary (WDSafe)

@end

@implementation NSDictionary (WDSafe)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("__NSPlaceholderDictionary") swizzleOriginInstanceMethod:@selector(initWithObjects:forKeys:count:)
                                                         swizzledInstanceMethod:@selector(safe_initWithObjects:forKeys:count:)];
        [objc_getClass("__NSDictionaryM") swizzleOriginInstanceMethod:@selector(removeObjectForKey:)
                                               swizzledInstanceMethod:@selector(safe_removeObjectForKey:)];
        [objc_getClass("__NSDictionaryM") swizzleOriginInstanceMethod:@selector(setObject:forKey:)
                                               swizzledInstanceMethod:@selector(safe_setObject:forKey:)];
    });
}

-(instancetype)safe_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    
    id validObjects[cnt];
    id<NSCopying> validKeys[cnt];
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < cnt; i++){
        if (objects[i] && keys[i]){
            validObjects[count] = objects[i];
            validKeys[count] = keys[i];
            count ++;
        }
    }
    return [self safe_initWithObjects:validObjects forKeys:validKeys count:count];
}

- (void)safe_removeObjectForKey:(id)aKey {
    if (!aKey) {
        return;
    }
    [self safe_removeObjectForKey:aKey];
}

- (void)safe_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    [self safe_setObject:anObject forKey:aKey];
}


@end

