//
//  DLMenuView.h
//  02-menuView
//
//  Created by vera on 16/4/6.
//  Copyright © 2016年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DLMenuViewDidClickAtIndexCallBack)(NSInteger index);

@interface DLMenuView : UIView

/**
 *  标题
 */
@property (nonatomic, strong) NSArray *menuTitles;

/**
 *  默认标题颜色。默认黑色
 */
@property (nonatomic, strong) UIColor *normalTextColor;

/**
 *  选中标题的颜色。默认是红色
 */
@property (nonatomic, strong) UIColor *selectTextColor;

/**
 *  选中的index。默认是0
 */
@property (nonatomic, assign) NSInteger selectedIndex;


- (void)setDLMenuViewDidClickAtIndexCallBack:(DLMenuViewDidClickAtIndexCallBack)callback;

@end

@interface DLMenuView (Aspects)

- (void)dlMenuView:(DLMenuView *)menuView atIndex:(NSInteger)atIndex;

@end
