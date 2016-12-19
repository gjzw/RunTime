//
//  EMRuntime.m
//  EMBusiness
//
//  Created by gjz on 15/11/2.
//  Copyright © 2015年 gjz. All rights reserved.
//

#import "EMRuntime.h"
#import <objc/runtime.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSRange.h>
#import <Foundation/NSObjCRuntime.h>

#pragma mark - ---- NSObject



@implementation NSObject (ResolveNoMethod)

#pragma mark - swizzle method

+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    [self swizzleInstanceMethod:object_getClass(self) originSelector:originSelector otherSelector:otherSelector];
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originSelector,
                    method_getImplementation(otherMehtod),
                    method_getTypeEncoding(otherMehtod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            otherSelector,
                            method_getImplementation(originMehtod),
                            method_getTypeEncoding(originMehtod));
    }
    else {
        // 交换2个方法的实现
        method_exchangeImplementations(otherMehtod, originMehtod);
    }
}

#pragma mark - basic method

+(void)load {
    
    if (NSClassFromString(@"NSObject")) {
        SEL originalSelector = @selector(methodSignatureForSelector:);
        SEL swizzledSelector = @selector(swizzled_methodSignatureForSelector:);
        
        [self swizzleInstanceMethod:[NSObject class] originSelector:originalSelector otherSelector:swizzledSelector];
        
        originalSelector = @selector(forwardInvocation:);
        swizzledSelector = @selector(swizzled_forwardInvocation:);
        
        [self swizzleInstanceMethod:[NSObject class] originSelector:originalSelector otherSelector:swizzledSelector];
        
    }
}



#pragma mark - 返回方法简介（签名信息）
- (NSMethodSignature *)swizzled_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self swizzled_methodSignatureForSelector:aSelector];
    if (signature == nil) {
        if ([EMRuntime instancesRespondToSelector:aSelector]) {
            signature = [EMRuntime instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}
#pragma mark - 方法传递
-(void)swizzled_forwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:anInvocation.selector]) {
        [self swizzled_forwardInvocation:anInvocation];
    }
    else{ //TODO:只有自己的类需要过滤，其他系统类无需过滤
#ifdef DEBUG
        NSAssert(NO, @"找不到方法：%@:%@",NSStringFromClass([self class]),NSStringFromSelector(anInvocation.selector));
#else
        NSLog(@"there is a serious problem with method name:%@",NSStringFromSelector(anInvocation.selector));
#endif
    }
    
}


@end





#pragma mark - ---- EMRuntime


//新生 selector列表
static NSMutableArray *SelectorList ;


@implementation EMRuntime

+(BOOL)resolveInstanceMethod:(SEL)sel {
    if (SelectorList == nil) {
        SelectorList = [[NSMutableArray alloc]init];
        [SelectorList addObject:@"methodForAllSelector"];
    }
    
    
    //方法存在判断
    for (NSString *selectorString in SelectorList) {
        if ([selectorString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    
    [SelectorList addObject:NSStringFromSelector(sel)];
    
    SEL originalSelector = @selector(methodForAllSelector);
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    
    //新增方法
    BOOL didAddMethod =
    class_addMethod([self class],
                    sel,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod));
    
    
    if (didAddMethod) {
        return YES;
    }
    
    return NO;
}

//替代所有未知方法的方法
-(void)methodForAllSelector {
    
}



@end
