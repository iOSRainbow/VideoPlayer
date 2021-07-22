//
//  BaseController.m
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden=YES;
    
    self.view.backgroundColor=[UIColor blackColor];
    
    //自定义导航栏
    navView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationHeight)];
    navView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:navView];
}



@end
