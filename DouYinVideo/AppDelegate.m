//
//  AppDelegate.m
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController=[[MainTabBarController alloc] init];
    
    
    return YES;
}



@end
