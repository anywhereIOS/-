//
//  UserModel.h
//  环信基本集成
//
//  Created by 王涛 on 16/4/3.
//  Copyright © 2016年 304. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCopying,NSCoding>
/**
 *  用户id
 */
@property (nonatomic,copy) NSString *userId;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *nickName;
/**
 *  用户状态
 */
@property (nonatomic,copy) NSString *userState;
/**
 *  用户的登陆类型
 */
@property (nonatomic,copy) NSString *loginType;
/**
 *  环信用户名
 */
@property (nonatomic,copy) NSString *hxUserName;
/**
 *  环信密码
 */
@property (nonatomic,copy) NSString *hxPasswd;
/**
 *  用户的token
 */
@property (nonatomic,copy) NSString *ptToken;

/**获取当前用户*/
+ (id) currentUser;
/**保存当前用户*/
+ (void) saveMySelf;
/**恢复当前用户*/
+ (id) restoreMyself;
/**判断用户是否存在*/
+ (BOOL) isExistMyself;
/**删除用户*/
+ (void)deleteMyself;
/**把对象self拷贝到target*/
- (id)copyToObject:(id)target;

#define mySelf ((UserModel *)[UserModel currentUser])

@end
