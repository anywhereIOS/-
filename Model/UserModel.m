//
//  UserModel.m
//  环信基本集成
//
//  Created by 王涛 on 16/4/3.
//  Copyright © 2016年 304. All rights reserved.
//

#import "UserModel.h"
#import "AutoCoding.h"
@implementation UserModel
/* 这里的属性都是可选的
 如果Model中属性多了 也不要管
 */
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return  YES;
}

static  UserModel* _currUer;


+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t oneUser;
    dispatch_once(&oneUser, ^{
        _currUer = [super allocWithZone:zone];
    });
    return _currUer;
}


/**获取当前用户*/
+ (id) currentUser
{
    if (_currUer == nil) {
        _currUer = [[UserModel alloc] init];
    }
    return _currUer;
}

#pragma mark - 使用AutoCoding自动进行归档
//获取当前的归档后保存的路径
static inline NSString * myselfSaveFile() {
    return [NSHomeDirectory() stringByAppendingString:@"/Library/myself"];
}


/**保存当前用户*/
+ (void) saveMySelf
{
    UserModel * userModel = mySelf;
    NSString * path = myselfSaveFile();
    [mySelf writeToFile:path atomically:YES];
}
/**恢复当前用户*/
+ (id) restoreMyself
{
    NSString * path = myselfSaveFile();
    UserModel * um = [self objectWithContentsOfFile:path];
    return um;
}


/**判断用户是否存在*/
+ (BOOL) isExistMyself
{
    NSString * path = myselfSaveFile();
    id obj = [self objectWithContentsOfFile:path];
    if ([obj isKindOfClass:[self class]]) {
        return YES;
    }
    return NO;
}
/**删除用户*/
+ (void)deleteMyself
{
    NSString * path = myselfSaveFile();
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

#pragma mark - 自动实现了拷贝NSCopying功能
- (id)copyWithZone:(NSZone *)zone
{
    UserModel * copy = [[[self class] allocWithZone:zone] init];
    for (NSString * key in [self codableProperties]) {
        [copy setValue:[self valueForKey:key] forKey:key];
    }
    return copy;
}


/**把对象self拷贝到target*/
- (id)copyToObject:(id)target
{
    for (NSString * key in [self codableProperties]) {
        [target setValue:[self valueForKey:key] forKey:key];
    }
    return target;
}

@end
