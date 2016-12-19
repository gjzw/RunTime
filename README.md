# RunTime
### 通过runtime实现对系统方法中一些注意点进行保护
### 实现数组越界过滤
### 可变数组添加元素 nil保护
### 可变字典添加key value nil保护
### NSString index保护
### UIView加自身保护
## 实现
### 对UIView加自身进行解析
```Objective-C
+(void)load {
    [self swizzleInstanceMethod:NSClassFromString(@"UIView") originSelector:@selector(addSubview:) otherSelector:@selector(swizzled_addSubview:)];
}

- (void)swizzled_addSubview:(UIView *)view {
    //出现加自己的情形
    if (view == self) {
#ifdef DEBUG
        //debug阶段显示出来 release阶段直接过滤
        NSLog(@"Can't add self as subview. Self is %@, view is %@", self, view);
        NSAssert(NO, @"Can't add self as subview");
#endif
        return;
    }
    
    [self swizzled_addSubview:view];
}
```
## 效果
![](https://raw.githubusercontent.com/gjzw/RunTime/master/source/img1.gif)
