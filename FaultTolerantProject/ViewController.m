//
//  ViewController.m
//  FaultTolerantProject
//
//  Created by Jacue on 2017/7/18.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 数组容错
    [self arrayFaultTolerant];
    
    // 字典容错
    [self dictionaryFaultTolerant];
    
    // 字符串容错
    [self stringFaultTolerant];
}


/**
  数组容错
 */
- (void)arrayFaultTolerant {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    
    // __NSPlaceholderArray
    id obj1 = [NSArray alloc];
    id obj2 = [NSMutableArray alloc];
    
    // __NSArray0
    NSArray *arr1 = [NSArray array];
    // __NSSingleObjectArrayI
    NSArray *arr2 = [NSArray arrayWithObject:@1];
    // __NSArrayI
    NSArray *arr3 = [NSArray arrayWithObjects:@1,@2,nil];
    NSArray *arr4 = [NSArray arrayWithObjects:@1,@2,@3,nil];
    
    // __NSArrayM
    NSMutableArray *mutableArr1 = [NSMutableArray array];
    NSMutableArray *mutableArr2 = [NSMutableArray arrayWithObject:@1];
    NSMutableArray *mutableArr3 = [NSMutableArray arrayWithObjects:@1,@2,nil];
    NSMutableArray *mutableArr4 = [NSMutableArray arrayWithObjects:@1,@2,@3,nil];
    
    
    NSNumber *num1 = arr1[3];
    NSNumber *num2 = arr2[3];
    NSNumber *num3 = arr3[3];
    NSNumber *num4 = mutableArr4[3];
    
    // ---------------- array 初始化容错 ---------------- //
    // [__NSPlaceholderArray initWithObjects:count:]
    
    // 1、便捷初始化
    NSArray *arr = @[num1];
    
    // 2、实例方法初始化
    id validObjects[1];
    validObjects[0] = num1;
    NSArray *array5 = [[NSArray alloc] initWithObjects:validObjects count:1];
    NSMutableArray *mutableArray5 = [[NSMutableArray alloc] initWithObjects:validObjects count:1];
    
    // 类方法调用实例方法 [__NSPlaceholderArray initWithObjects:count:]
    NSArray *array6 = [NSArray arrayWithObject:num1];
    //    NSMutableArray *mutableArray6 = [NSMutableArray arrayWithObject:num1];
    
    NSArray *array7 = [NSArray arrayWithObjects:validObjects count:1];
    //    NSMutableArray *mutableArray7 = [NSMutableArray arrayWithObjects:validObjects count:1];
    
    NSArray *array8 = [[NSArray alloc] initWithArray:array7];
    //    NSMutableArray *mutableArray8 = [[NSMutableArray alloc] initWithArray:mutableArray7];
    
    // ---------------- NSMutableArray 增删改查 ---------------- //

    mutableArr4[0] = num1;
    [mutableArr4 addObject:num1];
    [mutableArr4 removeObjectAtIndex:5];
    [mutableArr4 replaceObjectAtIndex:5 withObject:@1];
    
#pragma clang diagnostic pop

}



/**
 字典容错
 */
- (void)dictionaryFaultTolerant {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

    // __NSPlaceholderDictionary
    id obj1 = [NSDictionary alloc];
    id obj2 = [NSMutableDictionary alloc];
    
    // __NSDictionary0
    NSDictionary *dic1 = [NSDictionary dictionary];
    // __NSSingleEntryDictionaryI
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"key",@"value", nil];
    // __NSDictionaryI
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"key",@"value",@"key1",@"value1", nil];

    // __NSDictionaryM
    NSMutableDictionary *mutableDic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *mutableDic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key",@"value", nil];
    NSMutableDictionary *mutableDic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key",@"value",@"key1",@"value1", nil];
   
    // initWithObjects:forKeys:count:
    NSString *keyValue = nil;
    NSDictionary *dic4 = @{@"key":keyValue};
    NSMutableDictionary *mutableDic4 = @{@"key":keyValue}.mutableCopy;
//    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"key1",@"value1",@"key",keyValue, nil];
    
#pragma clang diagnostic pop
   
}



/**
 字符串容错
 */
- (void)stringFaultTolerant {
 
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

    id obj1 = [NSString alloc];
    id obj2 = [NSMutableString alloc];
    
    // __NSCFConstantString
    NSString *str1 = [NSString string];
    // NSTaggedPointerString
    NSString *str2 = [NSString stringWithFormat:@"123"];
    // __NSCFString
    NSString *str3 = [NSString stringWithFormat:@"1234561678"];
    NSString *str4 = [NSMutableString string];
    
    NSString *nilString = nil;
    [str1 stringByAppendingString:nilString];
    [str2 stringByAppendingString:nilString];
    [str3 stringByAppendingString:nilString];
    
    [str2 substringFromIndex:10];
    [str4 substringFromIndex:10];
    
    
#pragma clang diagnostic pop
    
}




@end
