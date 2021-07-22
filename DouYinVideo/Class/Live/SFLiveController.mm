//
//  LiveController.m
//  DouYinVideo
//
//  Created by mac on 2021/7/21.
//

#import "SFLiveController.h"
//#import "LFLiveKit.h"

@interface SFLiveController ()

//@property (nonatomic, strong)LFLiveSession *session;

@end

@implementation SFLiveController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.session  = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration] captureType:LFLiveCaptureDefaultMask];
//    self.session.preView= self.view;
//    //设置代理
//    self.session.delegate = self;
//    self.session.running = YES;
    
    //_session.torch =!_session.torch;//闪光灯开关
    //_session.muted = !_session.muted;//静音开关
    
    //切换摄像头
    //AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    //self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
}

/*

-(void)startLive{
    
    LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
    stream.url = @"";
    [self.session startLive:stream];
}

-(void)stopLive{
    
    [self.session stopLive];
}

- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
    
    switch (state) {
       
        case 0:
            NSLog(@"准备中");
            break;
      
        case 1:
            NSLog(@"连接中");
            break;
            
        case 2:
            NSLog(@"已连接");
            break;
            
        case 3:
            NSLog(@"已断开");
            break;
            
        case 4:
            NSLog(@"连接出错");
            break;
            
        case 5:
            NSLog(@"正在刷新");
            break;
            
        default:
            break;
    }
}

- (void)liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
 
    switch (errorCode) {
       
        case 201:
            NSLog(@" 预览失败");
            break;
      
        case 202:
            NSLog(@"获取流媒体信息失败");
            break;
            
        case 203:
            NSLog(@"连接socket失败");
            break;
            
        case 204:
            NSLog(@"验证服务器失败");
            break;
            
        case 205:
            NSLog(@"重新连接服务器超时");
            break;
   
        default:
            break;
    }
}

- (void)liveSession:(LFLiveSession *)session debugInfo:(LFLiveDebug *)debugInfo{
    
    
}
*/
@end
