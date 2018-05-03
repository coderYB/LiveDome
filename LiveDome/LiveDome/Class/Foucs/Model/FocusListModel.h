//
//  FocusListModel.h
//  LiveDome
//
//  Created by zbwx on 2018/5/3.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusListModel : NSObject
@property (nonatomic,strong) NSMutableArray * list;
@end

@interface FocusModel : NSObject
/** 直播流地址 */
@property (nonatomic, copy  ) NSString   *flv;
/** 所在城市 */
@property (nonatomic, copy  ) NSString   *position;
/** 主播名 */
@property (nonatomic, copy  ) NSString   *nickname;
/** 用户ID */
@property (nonatomic, assign) NSString   *useridx;
/** 朝阳群众数目 */
@property (nonatomic, assign) NSUInteger allnum;
/** 直播房间号码 */
@property (nonatomic, assign) NSUInteger roomid;
/** 主播头像 */
@property (nonatomic, copy  ) NSString   *photo;

@end
