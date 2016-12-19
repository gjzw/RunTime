//
//  NSArray+Runtime.m
//  EMBusiness
//
//  Created by gjz on 15/11/3.
//  Copyright © 2015年 gjz. All rights reserved.
//

#import "NSArray+Runtime.h"

@implementation NSArray (Runtime)

+(void)load {
    if (NSClassFromString(@"__NSArrayI")) {
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzledSelector = @selector(swizzled_objectAtIndex:);
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:originalSelector otherSelector:swizzledSelector];
    }
}

- (id)swizzled_objectAtIndex:(NSUInteger)index {
    if ([self count] <= index) {
#ifdef DEBUG
        NSAssert(NO, @"index %ld > count %ld", (long)index, (long)(self.count));
#else
        return nil;
#endif
        
    }
    return [self swizzled_objectAtIndex:index];
}


@end
