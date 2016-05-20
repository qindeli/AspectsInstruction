//
//  DLMenuView.m
//  02-menuView
//
//  Created by vera on 16/4/6.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "DLMenuView.h"

//按钮宽度
#define kMenuButtonWidth 80

//默认文字颜色
#define kMenuButtonNormalTextColor [UIColor blackColor]

//选中文字颜色
#define kMenuButtonSelectTextColor [UIColor redColor]

@interface DLMenuView ()
{
    DLMenuViewDidClickAtIndexCallBack _menuViewDidClickAtIndexCallBack;
}

@property (nonatomic, weak) UIScrollView *menuScrollView;

@end

@implementation DLMenuView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _normalTextColor = kMenuButtonNormalTextColor;
        _selectTextColor = kMenuButtonSelectTextColor;
    }
    return self;
}

#pragma mark - 懒加载
- (UIScrollView *)menuScrollView
{
    if (!_menuScrollView)
    {
        UIScrollView *menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                      0,
                                                                                      self.frame.size.width,
                                                                                      self.frame.size.height)];
        menuScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:menuScrollView];
        
        _menuScrollView = menuScrollView;
    }
    
    return _menuScrollView;
}

#pragma mark - setter方法
- (void)setMenuTitles:(NSArray *)menuTitles
{
#if 0
    if (menuTitles.count == 0)
    {
        NSAssert(menuTitles.count > 0, @"menuTitles长度不能为0");
    }
#endif
    
    //0.赋值
    _menuTitles = menuTitles;
    
    //1.判断数组不能为空，否则直接返回
    if (menuTitles.count == 0)
    {
        return;
    }
    
    //2.根据标题个数创建按钮
    for (int i = 0; i < menuTitles.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kMenuButtonWidth * i, 0, kMenuButtonWidth, self.frame.size.height);
        [button setTitle:menuTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:_normalTextColor forState:UIControlStateNormal];
        [button setTitleColor:_selectTextColor forState:UIControlStateSelected];
        button.tag = i + 1;
        [button addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.menuScrollView addSubview:button];
        
        //第一个按钮选中
        if (i == self.selectedIndex)
        {
            button.selected = YES;
        }
    }
    
    
    //3.设置滚动范围
    self.menuScrollView.contentSize = CGSizeMake(kMenuButtonWidth * _menuTitles.count, self.menuScrollView.frame.size.height);
    
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    _normalTextColor = normalTextColor;
    
    //修改按钮文字颜色
    [self modifyMenuButtonTextColorWithControlState:UIControlStateNormal];
}

- (void)setSelectTextColor:(UIColor *)selectTextColor
{
    _selectTextColor = selectTextColor;
    
    //修改按钮文字颜色
    [self modifyMenuButtonTextColorWithControlState:UIControlStateSelected];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    

    //修改偏移量
    
    //获取选中的按钮
    UIButton *selectedButton = (UIButton *)[self.menuScrollView viewWithTag:selectedIndex+1];
    
    //1.修改按钮状态
    [self modifyMenuButtonStatus:selectedButton];
    
    //2.修改偏移量
    [self handleMenuButtonCenter:selectedButton];

    
}

- (void)setDLMenuViewDidClickAtIndexCallBack:(DLMenuViewDidClickAtIndexCallBack)callback
{
    _menuViewDidClickAtIndexCallBack = callback;
}

#pragma mark - 修改按钮的颜色
- (void)modifyMenuButtonTextColorWithControlState:(UIControlState)controlState
{
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        UIButton *btn = (UIButton *)[self.menuScrollView viewWithTag:i+1];

        UIColor *color = nil;
        
        //默认状态
        if (controlState == UIControlStateNormal)
        {
            color = self.normalTextColor;
        }
        else if (controlState == UIControlStateSelected)
        {
            color = self.selectTextColor;
        }
        
        [btn setTitleColor:color forState:controlState];
    }
}

#pragma mark - 修改按钮状态
- (void)modifyMenuButtonStatus:(UIButton *)selectedButton
{
    //1.标题修改为默认的颜色
    for (int i = 0; i < self.menuTitles.count; i++)
    {
        UIButton *unSelectedButton = (UIButton *)[self.menuScrollView viewWithTag:i+1];
        unSelectedButton.selected = NO;
    }
    
    //2.标题修改为选中的颜色
    selectedButton.selected = YES;
}

#pragma mark - 按钮事件方法
- (void)menuButtonClick:(UIButton *)selectedButton
{
    //1.修改按钮状态
    [self modifyMenuButtonStatus:selectedButton];
    
    //2.处理滚动视图坐标---将选中的按钮居中
    [self handleMenuButtonCenter:selectedButton];
    
    //3.回调
    if (_menuViewDidClickAtIndexCallBack)
    {
        _menuViewDidClickAtIndexCallBack(selectedButton.tag - 1);
    }
    
    //4.调用分类方法
    [self dlMenuView:self atIndex:selectedButton.tag - 1];
}

- (void)handleMenuButtonCenter:(UIButton *)centerButton
{
    //0.获取按钮的中心点坐标
    CGFloat buttonCenterX = centerButton.center.x;
    
    //1.获取X偏移量 = 点击的按钮的中心点坐标 - menuView的宽度的一样。
    CGFloat xOffset = buttonCenterX - self.frame.size.width/2;
    
    //2.校验坐标
    if(buttonCenterX < self.frame.size.width/2)
    {
        xOffset = 0;
    }
    else if(buttonCenterX > self.menuScrollView.contentSize.width - self.frame.size.width / 2)
    {
        xOffset = self.menuScrollView.contentSize.width - self.frame.size.width;
    }
    
    //3.修改偏移量
    [self.menuScrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation DLMenuView (Aspects)

- (void)dlMenuView:(DLMenuView *)menuView atIndex:(NSInteger)atIndex
{
    
}

@end
