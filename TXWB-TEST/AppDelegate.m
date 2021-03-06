//
//  AppDelegate.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "AppDelegate.h"
#import "OauthVC.h"
#import "OneVC.h"
#import "TwoVC.h"
#import "ThreeVC.h"
#import "FourVC.h"
@implementation AppDelegate

- (void)changeVC
{
    OneVC *oneVC = [[OneVC alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:oneVC];

    
    TwoVC *twoVC = [[TwoVC alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:twoVC];

    ThreeVC *threeVC = [[ThreeVC alloc] init];
    //UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:threeVC];

    FourVC *fourVC = [[FourVC alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:fourVC];

    self.tabBarController = [[UITabBarController alloc] init];
    
    //[_tabBarController.tabBar setTintColor:[UIColor colorWithRed:100/255.0 green:200/255.0 blue:1 alpha:0.8]];
    
    NSArray *arrControllers = [[NSArray alloc] initWithObjects:nav1,nav2,threeVC,nav4, nil];
    
    _tabBarController.viewControllers = arrControllers;
    
    self.window.rootViewController = _tabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVC) name:@"changeVC" object:nil];
    
    OauthVC *oauthVC = [[OauthVC alloc] init];
    self.window.rootViewController = oauthVC;
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
