//
//  UIScrollView+YBTool.h
//  YBTool
//
//  Created by zbwx on 2018/4/4.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YBTool)
/**
 *  添加上下滑刷新  起始刷新
 *
 *  @param headerAction 头部刷新的触发事件   没有不添加刷新
 *  @param footerAction 尾部刷新的触发事件   没有不添加刷新
 *  @param target       target对象
 */
- (void)addRefreshWithheaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target;
/**
 *  添加上下滑刷新
 *
 *  @param headerAction 头部刷新的触发事件   没有不添加刷新
 *  @param footerAction 尾部刷新的触发事件   没有不添加刷新
 *  @param target       target对象
 */
- (void)addRefreshWithheaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target beginRefresh:(BOOL)isRefresh;
/**
 *  添加上下滑刷新
 *
 *  @param headerAction                     头部刷新的触发事件   没有不添加刷新
 *  @param footerAction                     尾部刷新的触发事件   没有不添加刷新
 *  @param target                           target对象
 *  @param ignoredScrollViewContentInsetTop 忽略多少像素  一般用于改变scollViewinSets时使用
 */
- (void)addRefreshWithheaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target WithignoredScrollViewContentInsetTop:(float)ignoredScrollViewContentInsetTop;
/**
 *  添加动画上滑刷新  下滑刷新
 *
 *  @param headerAction 头部刷新的触发事件   没有不添加刷新
 *  @param footerAction 尾部刷新的触发事件   没有不添加刷新
 *  @param target       target对象
 */
- (void)addRefreshForAnimationWithHeaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target;
/**
 *  开始刷新
 */
- (void)beginHeaderRefresh;
/**
 *  结束刷新
 */
- (void)endHeaderRefresh;
- (void)endFooterRefresh;


/**
 *  根据视图尺寸获取视图截屏（一屏无法显示完整）,适用于UIScrollView UITableviewView UICollectionView UIWebView
 *
 *  @return UIImage 截取的图片
 */
- (UIImage *)scrollViewCutterWithScale:(CGFloat)sacale;

@end
