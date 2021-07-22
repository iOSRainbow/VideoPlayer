//
//  Config.h
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#ifndef Config_h
#define Config_h


///判断是否为iPhone X 系列
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define GL_isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define GL_isIPhone_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

#define GL_isIPhone_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

#define GL_isIPhone_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

#define GL_isIPhone_iPhone12_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

#define GL_isIPhone_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

#define GL_isIPhone_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

#define GL_isIPhone_iPhone12_ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !GL_isPad : NO)

///导航栏高度
#define NavigationHeight ((GL_isIPhone_Xr == YES || GL_isIPhone_Xs == YES || GL_isIPhone_Xs_Max == YES || GL_isIPhone_iPhone12_Mini == YES) ? 88.0 : (GL_isIPhone_X == YES) ? 92 : (GL_isIPhone_iPhone12 == YES || GL_isIPhone_iPhone12_ProMax == YES) ? 91 : 64.0)

///若果是iPhoneX 则底部减去一个半圆弧度高
#define TabbarHeight (iPhoneX?34:0)

///状态栏
#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define TabbarStautsHeight (iPhoneX?83:49)

#define MS_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

///WEAKBLOCK
#define WEAKBLOCK(type) __weak __typeof(type) weak##type = type

///STRONGBLOCK
#define STRONGBLOCK(type) __strong __typeof(type) type = weak##type

#endif /* Config_h */
