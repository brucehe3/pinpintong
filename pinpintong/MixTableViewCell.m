//
//  MixTableViewCell.m
//  pinpintong
//
//  Created by Bruce He on 15-4-4.
//  Copyright (c) 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "MixTableViewCell.h"
#import "MixTableViewFrame.h"

#define NJNameFont [UIFont systemFontOfSize:15]
#define NJTextFont [UIFont systemFontOfSize:16]

@interface MixTableViewCell ()

// 名称
@property (nonatomic, weak) UILabel *nameLabel;

// 时间
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *contentLabel;


@end


@implementation MixTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"status";
    MixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[MixTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 让自定义Cell和系统的cell一样, 一创建出来就拥有一些子控件提供给我们使用
        
        // 4.创建正文
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = NJTextFont;

        contentLabel.numberOfLines = 0;
        // introLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = NJNameFont;
        //nameLabel.numberOfLines = 0;
        // introLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = NJNameFont;
        //timeLabel.numberOfLines = 0;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        

        

        
    }
    return self;
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

- (void)setViewFrame:(MixTableViewFrame *)viewFrame
{
    _viewFrame = viewFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置子控件的数据
 */
- (void)settingData
{
    
    NSDictionary *data = self.viewFrame.data;

    
    self.contentLabel.text = [data objectForKey:@"content"];
    
    self.nameLabel.text = [data objectForKey:@"username"];

}
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{

    // 设置昵称的frame
    self.nameLabel.frame = self.viewFrame.nameF;
       // 设置正文的frame
    self.contentLabel.frame = self.viewFrame.contentF;

}


@end
