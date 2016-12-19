//
//  NSMutableDictionary+Runtime.m
//  EMBusiness
//
//  Created by gjz on 15/11/3.
//  Copyright © 2015年 gjz. All rights reserved.
//

#import "NSMutableDictionary+Runtime.h"

@implementation NSMutableDictionary (Runtime)

+(void)load {
    [self swizzleInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setObject:forKey:) otherSelector:@selector(swizzled_setObject:forKey:)];
}



-(void)swizzled_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject == nil || aKey == nil) {
#ifdef DEBUG
        NSAssert(NO, @"key and content can't be nil for %@",NSStringFromClass([self class]));
#else
        NSLog(@"key and content can't be nil for %@",NSStringFromClass([self class]));
        return;
#endif
    }
    [self swizzled_setObject:anObject forKey:aKey];
}


@end
