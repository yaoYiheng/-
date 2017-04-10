//
//  YYHTopicsItem.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
 @property (nonatomic, assign) NSInteger cache_version;

 @property (nonatomic, strong) NSString *created_at;

 @property (nonatomic, strong) NSString *id;

 @property (nonatomic, strong) NSString *is_gif;

 @property (nonatomic, strong) NSString *voicetime;

 @property (nonatomic, strong) NSString *image2;

 @property (nonatomic, strong) NSString *voicelength;

 @property (nonatomic, strong) NSArray *top_cmt;

 @property (nonatomic, strong) NSString *playfcount;

 @property (nonatomic, strong) NSString *repost;

 @property (nonatomic, strong) NSString *bimageuri;

 @property (nonatomic, strong) NSString *image1;

 @property (nonatomic, strong) NSString *text;

 @property (nonatomic, strong) NSString *theme_type;

 @property (nonatomic, strong) NSString *hate;

 @property (nonatomic, strong) NSString *image0;

 @property (nonatomic, strong) NSString *comment;

 @property (nonatomic, strong) NSString *passtime;

 @property (nonatomic, strong) NSString *ding;

 @property (nonatomic, strong) NSString *type;

 @property (nonatomic, strong) NSString *playcount;

 @property (nonatomic, strong) NSString *tag;

 @property (nonatomic, strong) NSString *theme_name;

 @property (nonatomic, strong) NSString *create_time;

 @property (nonatomic, strong) NSString *favourite;

 @property (nonatomic, strong) NSArray *themes;

 @property (nonatomic, strong) NSString *name;

 @property (nonatomic, strong) NSString *height;

 @property (nonatomic, strong) NSString *status;

 @property (nonatomic, strong) NSString *videotime;

 @property (nonatomic, strong) NSString *bookmark;

 @property (nonatomic, strong) NSString *cai;

 @property (nonatomic, strong) NSString *screen_name;

 @property (nonatomic, strong) NSString *profile_image;

 @property (nonatomic, strong) NSString *love;

 @property (nonatomic, strong) NSString *user_id;

 @property (nonatomic, strong) NSString *theme_id;

 @property (nonatomic, strong) NSString *original_pid;

 @property (nonatomic, assign) NSInteger t;

 @property (nonatomic, strong) NSString *weixin_url;

 @property (nonatomic, strong) NSString *voiceuri;

 @property (nonatomic, strong) NSString *videouri;
 
 @property (nonatomic, strong) NSString *width;
 */

#import <Foundation/Foundation.h>


//typedef enum{
//
//    YYHTopicTypeAll = 1,
//    YYHTopicTypeVideo = 41,
//    YYHTopicTypeVoice = 31,
//    YYHTopicTypePicture = 10,
//    YYHTopicTypeWord = 29,
//
//
//} YYHTopicType;

typedef NS_ENUM(NSInteger,YYHTopicType ) {
    
    YYHTopicTypeAll = 1,
    YYHTopicTypeVideo = 41,
    YYHTopicTypeVoice = 31,
    YYHTopicTypePicture = 10,
    YYHTopicTypeWord = 29,

};

@interface YYHTopicsItem : NSObject



/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 帖子类型*/
@property (nonatomic, assign) YYHTopicType type;

/** cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;

/** 最热评论*/
@property (nonatomic, strong) NSArray *top_cmt;

/** 播放数*/
@property (nonatomic, assign) NSInteger playcount;
/** 时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;

/** 小图*/
@property (nonatomic, strong) NSString *image0;
/** 中图*/
@property (nonatomic, strong) NSString *image2;
/** 大图*/
@property (nonatomic, strong) NSString *image1;


/** 宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 高度(像素) */
@property (nonatomic, assign) NSInteger height;

/** <#comments#>*/
@property (nonatomic, assign) CGRect middleFrame;
@end
