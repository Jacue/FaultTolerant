//
//  NSString+runtime.m
//  Pods
//
//
//

#import "NSString+runtime.h"
#import <objc/runtime.h>
#import "NSObject+runtime.h"

@interface NSString (runtime)

@end

@implementation NSString (runtime)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // appendString:
        [objc_getClass("__NSCFConstantString") swizzleOriginInstanceMethod:@selector(stringByAppendingString:)
                                            swizzledInstanceMethod:@selector(safe_stringByAppendingString:)];
        [objc_getClass("NSTaggedPointerString") swizzleOriginInstanceMethod:@selector(stringByAppendingString:)
                                            swizzledInstanceMethod:@selector(safe_stringByAppendingString:)];
        [objc_getClass("__NSCFString") swizzleOriginInstanceMethod:@selector(stringByAppendingString:)
                                            swizzledInstanceMethod:@selector(safe_stringByAppendingString:)];
        
        // substring
        [objc_getClass("__NSCFConstantString") swizzleOriginInstanceMethod:@selector(substringFromIndex:)
                                                    swizzledInstanceMethod:@selector(safe_substringFromIndex:)];
        [objc_getClass("NSTaggedPointerString") swizzleOriginInstanceMethod:@selector(substringFromIndex:)
                                                     swizzledInstanceMethod:@selector(safe_substringFromIndex:)];
        [objc_getClass("__NSCFString") swizzleOriginInstanceMethod:@selector(substringFromIndex:)
                                            swizzledInstanceMethod:@selector(safe_substringFromIndex:)];

        
    });
}

-(NSString *) safe_stringByAppendingString:(NSString *)aString
{
    if(aString == nil){
        return self;
    }
    
    return [self safe_stringByAppendingString:aString];
}

- (NSString *)safe_substringFromIndex:(NSUInteger)from {
    
    if (from > self.length ) {
        return nil;
    }
    return [self safe_substringFromIndex:from];
}


@end
