//
//  MainViewController.m
//  AspectsInstruction
//
//  Created by vera on 16/5/18.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "MainViewController.h"
#import "Aspects.h"
#import "DLMenuView.h"
#import "Aspects.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    


    DLMenuView *menuView = [[DLMenuView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 40)];
    //菜单栏标题
    menuView.menuTitles = @[@"新闻",@"头条",@"好声音",@"原创",@"视频",@"土豆",@"优酷",@"科技",@"图片"];
    menuView.backgroundColor = [UIColor yellowColor];
    //默认选择第1项
    menuView.selectedIndex = 0;
    [self.view addSubview:menuView];
    
#if 0
    //设置回调，目前回调就不用了。
    [menuView setDLMenuViewDidClickAtIndexCallBack:^(NSInteger index) {
        NSLog(@"click %ld",index);
    }];
#endif

    /**
     *  拦截menuView的dlMenuView:atIndex:方法
     */
    [menuView aspect_hookSelector:@selector(dlMenuView:atIndex:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspects, DLMenuView *menuView, NSInteger index)
     {
         
         NSLog(@"按钮点击了 %ld",index);
         
     } error:nil];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
