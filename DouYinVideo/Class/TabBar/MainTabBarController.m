//
//  MainTabBarController.m
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import "MainTabBarController.h"
#import "HomeController.h"
#import "MineController.h"
#import "SFLiveController.h"


@interface MainTabBarController ()
{
    UITabBarItem * homeItem;
    UITabBarItem * mineItem;
    UITabBarItem * liveItem;

}

@end

@implementation MainTabBarController


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.tabBar.translucent = NO;
        self.tabBar.barTintColor=[UIColor blackColor];
        

        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];

        NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
        selectTextAttrs[NSForegroundColorAttributeName] =[UIColor whiteColor];

        [[UITabBarItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        
        [self addChildViewController];
        

    }
    return self;
}

-(void)addChildViewController{
  
   [self setViewControllers:@[[self homeVC],[self liveVC],[self mineVC]] animated:YES];
}

-(UINavigationController*)homeVC{
    
    
    HomeController *main = [[HomeController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
    
    homeItem=[[UITabBarItem alloc] init];
    homeItem.title=@"首页";
    homeItem.tag=0;
    
    homeItem.image=[[UIImage imageNamed:@"tab_home_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeItem.selectedImage = [[UIImage imageNamed:@"tab_home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    main.tabBarItem = homeItem;
   
    return nav;
     
}

-(UINavigationController*)liveVC{
    
    
    SFLiveController *live = [[SFLiveController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:live];
    
    liveItem=[[UITabBarItem alloc] init];
    liveItem.title=@"直播";
    liveItem.tag=1;
    
    liveItem.image=[[UIImage imageNamed:@"tab_live_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    liveItem.selectedImage = [[UIImage imageNamed:@"tab_live_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    live.tabBarItem = liveItem;
   
    return nav;
     
}

-(UINavigationController*)mineVC{
    
   MineController *mine = [[MineController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mine];
    
    mineItem=[[UITabBarItem alloc] init];
    mineItem.title=@"我的";
    mineItem.tag=2;
    
    mineItem.image=[[UIImage imageNamed:@"tab_mine_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineItem.selectedImage = [[UIImage imageNamed:@"tab_mine_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mine.tabBarItem = mineItem;
   
    return nav;
     
}

     
- (void)viewDidLoad {
    
    [super viewDidLoad];    // Do any additional setup after loading the view.
}






@end
