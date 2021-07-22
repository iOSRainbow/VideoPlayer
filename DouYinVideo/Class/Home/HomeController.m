//
//  HomeController.m
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import "HomeController.h"
#import "VideoTableCell.h"
#import "VideoView.h"

#define offsetY 100


/*
 
 列表视频播放实现思路：
 1，UITableView ： Cell上展示视频第一帧图片，点赞，评论，头像等参数，均静态不可点击交互
 2，封装一个视频播放View，用于被addSubView在Cell上，视频播放View界面展示视频第一帧图片，点赞，评论，头像等可点击交互
 3，定义一个属性currentIndex，并添加他的观察属性，当currentIndex属性值改变时，处理视频播放功能
 4，UITableView滑动代理，处理视频上下滑动动画操作
 5，注意，整个UITableView中，只存在一个视频播放实例方法，这样性能提升
 直播功能的界面展示，也同样处理逻辑
 
 */


@interface HomeController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView * table;
    NSArray * dataArray;
    NSMutableArray * videoPicArray;//视频第一帧图片
}

@property(nonatomic,strong)VideoView * videoView;
@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation HomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initData];
    
    [self setupView];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        for (int i = 0; i < self->dataArray.count;i++) {
               
            UIImage * image = [self getVideoPreViewImage:[NSURL URLWithString:self->dataArray[i]]];
                   
            [self->videoPicArray replaceObjectAtIndex:i withObject:image];
                                    
            dispatch_async(dispatch_get_main_queue(), ^{
                        
                [self->table reloadData];
                 
            });
        }
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.videoView){
        
        [self.videoView play];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.videoView){
        
        [self.videoView pause];
    }
}


-(void)initData{
    
    dataArray=@[
        @"https://aweme.snssdk.com/aweme/v1/play/?video_id=ba8f4ff0c1fe445dbfdc1cc9565222fa&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
        @"http://ctgdev.oss-cn-shanghai.aliyuncs.com/zys/04795f79-697b-4647-958b-fed0261b2730.mp4",
        @"https://aweme.snssdk.com/aweme/v1/play/?video_id=ba8f4ff0c1fe445dbfdc1cc9565222fa&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
        @"http://ctgdev.oss-cn-shanghai.aliyuncs.com/zys/04795f79-697b-4647-958b-fed0261b2730.mp4",
        @"https://aweme.snssdk.com/aweme/v1/play/?video_id=ba8f4ff0c1fe445dbfdc1cc9565222fa&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0"];
    
    videoPicArray=[NSMutableArray array];
        
    for(int i=0;i<dataArray.count;i++){
        
        [videoPicArray addObject:[UIImage imageNamed:@"img_video_loading"]];
    }
}

-(void)setupView{
        
    navView.backgroundColor=MS_RGBA(0, 0, 0, 0);
    
    UILabel * liveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusHeight+10, 60, 20)];
    liveLabel.text=@"直播";
    liveLabel.font=[UIFont boldSystemFontOfSize:16];
    liveLabel.textAlignment=NSTextAlignmentCenter;
    liveLabel.textColor=[UIColor whiteColor];
    [navView addSubview:liveLabel];
    
    
    CGFloat leftX = (SCREEN_WIDTH-150)/3;
    
    UILabel * locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX+50, StatusHeight+10, 50, 20)];
    locationLabel.text=@"本地";
    locationLabel.font=[UIFont systemFontOfSize:17];
    locationLabel.textAlignment=NSTextAlignmentCenter;
    locationLabel.textColor=[UIColor whiteColor];
    [navView addSubview:locationLabel];
    
    UILabel * likeTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationLabel.frame), StatusHeight+10, 50, 20)];
    likeTitle.text=@"关注";
    likeTitle.font=[UIFont systemFontOfSize:16];
    likeTitle.textAlignment=NSTextAlignmentCenter;
    likeTitle.textColor=[UIColor whiteColor];
    [navView addSubview:likeTitle];
    
    UILabel * hotTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(likeTitle.frame), StatusHeight+10, 50, 20)];
    hotTitle.text=@"推荐";
    hotTitle.font=[UIFont boldSystemFontOfSize:16];
    hotTitle.textAlignment=NSTextAlignmentCenter;
    hotTitle.textColor=[UIColor whiteColor];
    [navView addSubview:hotTitle];
    
    UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, StatusHeight+10, 60, 20)];
    searchLabel.text=@"搜索";
    searchLabel.font=[UIFont boldSystemFontOfSize:16];
    searchLabel.textAlignment=NSTextAlignmentCenter;
    searchLabel.textColor=[UIColor whiteColor];
    [navView addSubview:searchLabel];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.delegate=self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.rowHeight=table.frame.size.height;
    table.backgroundColor=[UIColor blackColor];
    table.scrollsToTop=NO;
    table.contentInset=UIEdgeInsetsMake(0, 0, TabbarStautsHeight, 0);
    
    if (@available(ios 11.0,*)) {
        
        [table setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self.view addSubview:table];
    [self.view addSubview:navView];
    
    [table registerClass:[VideoTableCell class] forCellReuseIdentifier:@"VideoTableCell"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];

    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoTableCell" forIndexPath:indexPath];
    cell.bgImageView.image=videoPicArray[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
        CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
      
        scrollView.panGestureRecognizer.enabled = NO;
        NSLog(@"UITableView禁止响应其他滑动手势");
        
        if(translatedPoint.y < -offsetY && self.currentIndex < (self->dataArray.count - 1)) {
          
            self.currentIndex ++;
            NSLog(@"向下滑动索引递增");
        }
        
        if(translatedPoint.y > offsetY && self.currentIndex > 0) {
           
            self.currentIndex --;
            NSLog(@"向上滑动索引递减");
        }
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                
            [self->table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                           
        } completion:^(BOOL finished) {
                                
            scrollView.panGestureRecognizer.enabled = YES;
            NSLog(@"UITableView可以响应其他滑动手势");
        }];
    });
}


//观察currentIndex变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
    if ([keyPath isEqualToString:@"currentIndex"]) {
        
        NSLog(@"indexPath发生改变");
                    
        VideoTableCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
      
        [self.videoView removePlayer];
        [self.videoView removeFromSuperview];
        self.videoView=[[VideoView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, table.rowHeight) url:dataArray[self.currentIndex] image:videoPicArray[self.currentIndex]];
        [cell.contentView addSubview:self.videoView];
        [cell insertSubview:cell.middleView belowSubview:self.videoView];
        
        WEAKBLOCK(self);
        
        self.videoView.changeScreen = ^(BOOL isFull) {
            
            STRONGBLOCK(self);
            
            cell.bgImageView.hidden=YES;
            
            if(isFull){

                self.tabBarController.tabBar.hidden = YES;
                self->navView.hidden=YES;
                self->table.scrollEnabled=NO;
                cell.middleView.hidden=YES;
            
            }else{
                
                                        
                self.tabBarController.tabBar.hidden = NO;
                self->navView.hidden=NO;
                self->table.scrollEnabled=YES;
                cell.middleView.hidden=NO;
                cell.bgImageView.hidden=NO;

            }
            
        };
    }
}

//mark：一般真实项目，后台会返回视频第一帧图片url给端
// 获取网络视频第一帧
- (UIImage*)getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0, 1);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}



@end
