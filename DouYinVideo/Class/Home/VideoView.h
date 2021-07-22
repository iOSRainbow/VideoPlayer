//
//  VideoView.h
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoView : UIView
{
    UIView * sliderView;
    UIView * bottomView;
    
    UILabel *countTimeLabel;
    
    UIButton * startVideoBtn;
    UIButton * changeFullScreenBtn;
}

///真实项目中，直接用dict包裹入参
-(instancetype)initWithFrame:(CGRect)frame url:(NSString*)url image:(UIImage*)image;

@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property(nonatomic,strong) AVPlayerLayer *avLayer; //展示播放View
@property(nonatomic,strong)UILabel * currentTimeLabel;//当前倒计时
@property (nonatomic,strong)UISlider *slider;//滑竿
@property(nonatomic,assign)BOOL isFullScreen; //是否全屏状态 默认NO
@property (nonatomic, assign) CGRect smallFrame; //小屏幕frame
@property (nonatomic, assign) CGRect bigFrame; //全屏frame

///点击全屏，取消全屏回调
@property(nonatomic,copy)void(^changeScreen)(BOOL isFull);

///开始播放
-(void)play;

///暂停
-(void)pause;

///移除观察者
-(void)removePlayer;

@end

NS_ASSUME_NONNULL_END
