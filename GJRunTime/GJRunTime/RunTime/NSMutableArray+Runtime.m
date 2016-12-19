////
////  NSMutableArray+Runtime.m
////  EMBusiness
////
////  Created by gjz on 15/11/3.
////  Copyright © 2015年 gjz. All rights reserved.
////
//
#import "NSMutableArray+Runtime.h"

@implementation NSMutableArray (Runtime)

+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) otherSelector:@selector(swizzled_addObject:)];
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(swizzled_objectAtIndex:)];
}

- (void)swizzled_addObject:(id)object
{
    if (object != nil) {
        [self swizzled_addObject:object];
    }
    else {
#ifdef DEBUG
        NSAssert(NO, @"%@数组元素不可为nil",self);
#endif
    }
}

- (id)swizzled_objectAtIndex:(NSUInteger)index
{
    if ([self count] <= index) {
#ifdef DEBUG
        NSAssert(NO, @"index %ld > count %ld", (long)index, (long)(self.count));
#else
        if ([self count] == index) {
            return [self swizzled_objectAtIndex:index];
        }
        return nil;
#endif
        
    }
    return [self swizzled_objectAtIndex:index];
}


@end
