//
//  ZTVerifyWIFI.h
//  ZTVerifyWIFIDemo
//
//  Created by XiaoJin on 2018/2/26.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTVerifyWIFI : NSObject

/**
 * 验证的URL 默认为 http://captive.apple.com/hotspotdetect.html
 * 正常不需要设置
 */
@property (nonatomic, strong) NSURL  *verifyURL;

- (void)checkWIFIIsAvailable:(void(^)(BOOL needVerify))complection showAlert:(BOOL)showAlert;

@end
