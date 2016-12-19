//
//  NSString+Runtime.m
//  EMBusiness
//
//  Created by gjz on 15/11/3.
//  Copyright © 2015年 gjz. All rights reserved.
//

#import "NSString+Runtime.h"

@implementation NSString (Runtime)

+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(substringFromIndex:) otherSelector:@selector(swizzled_substringFromIndex:)];
    
    [self swizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(substringToIndex:) otherSelector:@selector(swizzled_substringToIndex:)];
    
    [self swizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(substringWithRange:) otherSelector:@selector(swizzled_substringWithRange:)];
}

-(NSString *)swizzled_substringFromIndex:(NSUInteger)from {
    if(from > [self length]) {
#ifdef DEBUG
        NSAssert(NO, @"%ld超出%@的长度",(long)from,self);
#endif
         return nil;
    }
    return [self swizzled_substringFromIndex:from];
}

-(NSString *)swizzled_substringToIndex:(NSUInteger)to {
    if(to > [self length]) {
#ifdef DEBUG
        NSAssert(NO, @"%ld超出%@的长度",(long)to,self);
#endif
        return nil;
    }
    return [self swizzled_substringToIndex:to];
}

-(NSString *)swizzled_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
#ifdef DEBUG
        NSAssert(NO, @"range(%ld,%ld）超出%@的长度",(long)(range.location), (long)(range.length),self);
#endif
        return nil;
    }
    return [self swizzled_substringWithRange:range];
}


@end
