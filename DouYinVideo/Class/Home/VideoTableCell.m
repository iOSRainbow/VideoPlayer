//
//  VideoTableCell.m
//  DouYinVideo
//
//  Created by mac on 2021/7/19.
//

#import "VideoTableCell.h"
#import "Config.h"

@implementation VideoTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.contentView.backgroundColor=[UIColor blackColor];
        
        CGFloat height = SCREEN_HEIGHT;
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        self.bgImageView.tag=100;
        self.bgImageView.image=[UIImage imageNamed:@"img_video_loading"];
        [self.contentView addSubview:self.bgImageView];
        
        self.middleView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, (height-150-StatusHeight)/2, 80, 50)];
        self.middleView.tag=200;
        [self.contentView addSubview:self.middleView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        titleLabel.text=@"头像";
        titleLabel.font=[UIFont boldSystemFontOfSize:16];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.textAlignment = 1;
        [self.middleView addSubview:titleLabel];

        UILabel * titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), 80, 50)];
        titleLabel2.text=@"点赞";
        titleLabel2.font=[UIFont boldSystemFontOfSize:16];
        titleLabel2.textColor=[UIColor whiteColor];
        titleLabel2.textAlignment = 1;
        [self.middleView addSubview:titleLabel2];

        UILabel * titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel2.frame), 80, 50)];
        titleLabel3.text=@"评论";
        titleLabel3.font=[UIFont boldSystemFontOfSize:16];
        titleLabel3.textColor=[UIColor whiteColor];
        titleLabel3.textAlignment = 1;
        [self.middleView addSubview:titleLabel3];
    }
    
    return self;
}


@end
