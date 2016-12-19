//
//  UIView+Runtime.m
//  EMBusiness
//
//  Created by gjz on 16/1/4.
//  Copyright © 2016年 gjz. All rights reserved.
//

#import "UIView+Runtime.h"

@implementation UIView (Runtime)

+(void)load {
    [self swizzleInstanceMethod:NSClassFromString(@"UIView") originSelector:@selector(addSubview:) otherSelector:@selector(swizzled_addSubview:)];
}

- (void)swizzled_addSubview:(UIView *)view {
    if (view == self) {
#ifdef DEBUG
        NSLog(@"Can't add self as subview. Self is %@, view is %@", self, view);
        NSAssert(NO, @"Can't add self as subview");
#endif
        return;
    }
    
    [self swizzled_addSubview:view];
}

@end
