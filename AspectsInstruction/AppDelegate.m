//
//  AppDelegate.m
//  AspectsInstruction
//
//  Created by vera on 16/5/18.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Aspects.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    self.window.rootViewController = mainViewController;
    
    

//    /**
//     *  事件拦截
//     *  拦截UIViewController的viewDidLoad方法
//     */
//    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
//        
//        
//        //NSLog(@"viewDidLoad调用了 --- %@ --- %@ --- %@",aspectInfo.instance,aspectInfo.arguments, aspectInfo.originalInvocation);
//        NSLog(@"%@ 对象的viewDidLoad调用了",aspectInfo.instance);
//        
//        /**
//         *  添加我们要执行的代码，由于withOptions是AspectPositionAfter。
//         *  所以每个控制器的viewDidLoad触发都会执行下面的方法
//         */
//        [self doSomethings];
//        
//    } error:NULL];
    
    return YES;
}

- (void)doSomethings
{
    NSLog(@"------");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
