//
//  YHStatus.m
//  16_11_05_自定义不等高cell
//
//  Created by 姚懿恒 on 2016/11/5.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHStatus.h"

@implementation YHStatus

//- (instancetype)initWithDictionary:(NSDictionary *)dict{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}
//+ (instancetype)statusWithDictionary:(NSDictionary *)dict{
//    return [[self alloc] initWithDictionary:dict];
//}

- (CGFloat)cellHeight{
    if (_cellHeight == 0) {

        /** 重新计算影响cell高度的子控件并返回新高度.*/
        CGFloat space = 10;

        /**头像图片 */
        CGFloat iconX = space;
        CGFloat iconY = space;
        CGFloat iconWH = 30;
        self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);

        /**昵称 */
        CGFloat nameX = CGRectGetMaxX(self.iconFrame) + space;
        CGFloat nameY = space;

        NSDictionary *nameAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};

        CGSize nameSize = [self.name sizeWithAttributes:nameAttribute];
        CGFloat nameW = nameSize.width;
        CGFloat nameH = nameSize.height;

        self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);

        /**微博内容 */
        CGFloat contentX = iconX;
        CGFloat contentY = CGRectGetMaxY(self.iconFrame) + space;
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 *space;

        NSDictionary *contentAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);


        CGFloat contentH = [self.text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttribute context:nil].size.height;

        self.textFrame = CGRectMake(contentX, contentY, contentW, contentH);

        /**VIP */
        if (self.vip) {
            CGFloat vipX = CGRectGetMaxX(self.nameFrame) + space;
            CGFloat vipY = nameY;
            CGFloat vipW = 14;
            CGFloat vipH = nameH;
            self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
        }


        /**微博图片 */
        if (self.picture) {
            CGFloat pictureX = space;
            CGFloat pictureY = CGRectGetMaxY(self.textFrame) + space;
            CGFloat pictureWH = 150;
            self.pictureFrame = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);
            
            _cellHeight = CGRectGetMaxY(self.pictureFrame) + space;
        }
        else{
            _cellHeight = CGRectGetMaxY(self.textFrame) + space;
        }

    }
    return _cellHeight;
}
@end
