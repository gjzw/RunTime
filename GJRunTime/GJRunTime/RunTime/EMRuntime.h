//
//  EMRuntime.h
//  EMBusiness
//
//  Created by gjz on 15/11/2.
//  Copyright © 2015年 gjz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMRuntime : NSObject

@end


@interface NSObject (ResolveNoMethod)

+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;
+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;

@end