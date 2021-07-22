//
//  VideoView.m
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import "VideoView.h"
#import "Config.h"

@implementation VideoView


-(instancetype)initWithFrame:(CGRect)frame url:(NSString*)url image:(UIImage *)image{
    
    if(self=[super initWithFrame:frame]){
        
        self.isFullScreen = NO;
        self.smallFrame = frame;
        self.bigFrame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
                
        CGFloat height = frame.size.height;
        CGFloat width = frame.size.width;
        
        //占位，视频第一帧图片
        UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        bgImageView.image=image;
        bgImageView.userInteractionEnabled=YES;
        [self addSubview:bgImageView];
        
        //网络视频路径
        NSURL *webVideoUrl = [NSURL URLWithString:url];
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:webVideoUrl];
        self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

        self.avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.avLayer.backgroundColor=[UIColor blackColor].CGColor;
        self.avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.avLayer.frame = CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height);
        [bgImageView.layer addSublayer:self.avLayer];

        sliderView =[[UIView alloc] initWithFrame:frame];
        sliderView.hidden=YES;
        [self addSubview:sliderView];
        
        bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, sliderView.frame.size.height-50-TabbarStautsHeight, frame.size.width, 50)];
        bottomView.backgroundColor=MS_RGBA(0, 0, 0, 0.5);
        [sliderView addSubview:bottomView];

        startVideoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        startVideoBtn.frame=CGRectMake(0,0, 50, 50);
        [startVideoBtn setImage:[UIImage imageNamed:@"videoPauseBtn"] forState:normal];
        [startVideoBtn addTarget:self action:@selector(actStartVideo:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:startVideoBtn];
        
        self.currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
        self.currentTimeLabel.textColor=[UIColor whiteColor];
        self.currentTimeLabel.text=@"00:00";
        self.currentTimeLabel.font=[UIFont systemFontOfSize:14];
        self.currentTimeLabel.textAlignment=1;
        [bottomView addSubview:self.currentTimeLabel];
        
        self.slider=[[UISlider alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-200, 50)];
        self.slider.minimumValue=0;
        self.slider.minimumTrackTintColor=[UIColor whiteColor];
        self.slider.maximumTrackTintColor =[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        [self.slider addTarget:self action:@selector(avSliderAction) forControlEvents:
        UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchUpOutside];
        [self.slider setThumbImage:[UIImage imageNamed:@"slider"] forState:normal];
        [bottomView addSubview:self.slider];

        countTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.slider.frame), 0, 50, 50)];
        countTimeLabel.textColor=[UIColor whiteColor];
        countTimeLabel.text=@"00:00";
        countTimeLabel.font=[UIFont systemFontOfSize:14];
        countTimeLabel.textAlignment=1;
        [bottomView addSubview:countTimeLabel];
        
        changeFullScreenBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        changeFullScreenBtn.frame=CGRectMake(CGRectGetMaxX(countTimeLabel.frame),0, 50, 50);
        [changeFullScreenBtn setImage:[UIImage imageNamed:@"exitFullScreen"] forState:normal];
        [changeFullScreenBtn addTarget:self action:@selector(actChange:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:changeFullScreenBtn];
        changeFullScreenBtn.selected=NO;
        

        WEAKBLOCK(self);
        
        [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {

            STRONGBLOCK(self);
            
            NSInteger currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
            NSInteger countTime = CMTimeGetSeconds(self.player.currentItem.duration);

            self.currentTimeLabel.text=[self getMMSSFromSS:[NSString stringWithFormat:@"%zi",currentTime]];
            
            self.slider.value=currentTime;
            
            if(currentTime>=countTime){
                
                self.slider.value=0;
                [self.player seekToTime:CMTimeMake(0, 1)];

            }
        }];

        [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        UITapGestureRecognizer *hidenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottonView:)];
        [self addGestureRecognizer:hidenTap];
    }
    
    return self;
}


- (void)hiddenBottonView: (UITapGestureRecognizer *)tap {

    if (sliderView.hidden) {
        
        sliderView.hidden = NO;
        
    }else {
        
        sliderView.hidden = YES;
    }
}


- (void)avSliderAction{
    
    CGFloat seconds = self.slider.value;
    [self startPlayer:seconds];
}

-(void)startPlayer:(CGFloat)seconds{
    
    CMTime startTime = CMTimeMakeWithSeconds(seconds, self.player.currentTime.timescale);
    [self.player seekToTime:startTime];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.avLayer.frame=self.bounds;
    sliderView.frame=self.bounds;
    
    CGFloat topY = !self.isFullScreen?TabbarStautsHeight:0;
    
    CGFloat leftX = !self.isFullScreen?0:NavigationHeight;
    
    CGFloat spaceWidth = !self.isFullScreen?0:TabbarStautsHeight;
    
    bottomView.frame=CGRectMake(0, sliderView.frame.size.height-topY-50, sliderView.frame.size.width, 50);
    
    startVideoBtn.frame=CGRectMake(leftX, 0, 50, 50);

    self.currentTimeLabel.frame = CGRectMake(leftX+50, 0, 50, 50);

    self.slider.frame=CGRectMake(CGRectGetMaxX(self.currentTimeLabel.frame), 0, sliderView.frame.size.width-100-spaceWidth-CGRectGetMaxX(self.currentTimeLabel.frame), 50);

    countTimeLabel.frame = CGRectMake(sliderView.frame.size.width-100-spaceWidth, 0, 50, 50);

    changeFullScreenBtn.frame=CGRectMake(sliderView.frame.size.width-50-spaceWidth, 0, 50, 50);
}


//观察currentIndex变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
    if ([keyPath isEqualToString:@"status"]){
        
        //获取playerItem的status属性最新的状态
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:{
        
                NSInteger countTime = CMTimeGetSeconds(self.player.currentItem.duration);
                self.slider.maximumValue =countTime;
                countTimeLabel.text=[self getMMSSFromSS:[NSString stringWithFormat:@"%zi",countTime]];
                [self.player play];
                
                break;
            }
            case AVPlayerStatusFailed:{//视频加载失败，点击重新加载
             
                NSLog(@"视频播放失败");

                break;
            }
            case AVPlayerStatusUnknown:{
                
                NSLog(@"视频播放失败");
                break;
            }
            default:
                break;
        }
    }
}


-(void)play
{
    [self.player play];
}

-(void)pause{
    
    [self.player pause];
}

-(void)actStartVideo:(UIButton*)btn{
    
    if(!startVideoBtn.selected){
        
        startVideoBtn.selected=YES;
        [startVideoBtn setImage:[UIImage imageNamed:@"videoPlayBtn"] forState:normal];
        [self pause];
    
    }else{
        
        startVideoBtn.selected=NO;
        [startVideoBtn setImage:[UIImage imageNamed:@"videoPauseBtn"] forState:normal];
        [self play];
    }
}

-(void)actChange:(UIButton*)btn{
    
    if(!changeFullScreenBtn.selected){
        
        self.isFullScreen=YES;
        changeFullScreenBtn.selected=YES;
        [changeFullScreenBtn setImage:[UIImage imageNamed:@"exitFullScreen"] forState:normal];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI / 2);
        } completion:nil];

        self.frame=self.bigFrame;
        
        if(self.changeScreen){
            
            self.changeScreen(self.isFullScreen);
        }
        
    }else{
        
        changeFullScreenBtn.selected=NO;
        self.isFullScreen=NO;
        [changeFullScreenBtn setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:normal];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI * 2);
        } completion:^(BOOL finished) {
            
            if(self.changeScreen){
                
                self.changeScreen(self.isFullScreen);
            }
        }];
        
        self.frame=self.smallFrame;
    }
}


-(void)removePlayer{
    
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player pause];
}


-(NSString *)getMMSSFromSS:(NSString *)totalTime{

    NSInteger seconds = [totalTime integerValue];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}



@end
