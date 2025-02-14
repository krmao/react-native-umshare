//
//  ShareModule.h
//  UMComponent
//
//  Created by wyq.Cloudayc on 11/09/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "UMShareModule.h"
#import "RNUMConfigure.h"
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@implementation UMShareModule

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

- (NSArray<NSNumber *> *)platformTypesForStrings:(NSArray<NSString *> *)platformStrings {
    NSMutableArray<NSNumber *> *platformTypes = [NSMutableArray array];

    for (NSString *platformString in platformStrings) {
        UMSocialPlatformType platformType =
        [self platformTypeForString:platformString];
        [platformTypes addObject:@(platformType)];
    }

    return platformTypes;
}

- (UMSocialPlatformType)platformTypeForString:(NSString *)platformString {
    if ([platformString isEqualToString:@"SMS"]) {
        return UMSocialPlatformType_Sms;
    } else if ([platformString isEqualToString:@"EMAIL"]) {
        return UMSocialPlatformType_Email;
    } else if ([platformString isEqualToString:@"SINA"]) {
        return UMSocialPlatformType_Sina;
    } else if ([platformString isEqualToString:@"QZONE"]) {
        return UMSocialPlatformType_Qzone;
    } else if ([platformString isEqualToString:@"QQ"]) {
        return UMSocialPlatformType_QQ;
    } else if ([platformString isEqualToString:@"WEIXIN"]) {
        return UMSocialPlatformType_WechatSession;
    } else if ([platformString isEqualToString:@"WEIXIN_CIRCLE"]) {
        return UMSocialPlatformType_WechatTimeLine;
    } else if ([platformString isEqualToString:@"WEIXIN_FAVORITE"]) {
        return UMSocialPlatformType_WechatFavorite;
    } else if ([platformString isEqualToString:@"WXWORK"]) {
        return UMSocialPlatformType_WechatWork;
    } else if ([platformString isEqualToString:@"DOUBAN"]) {
        return UMSocialPlatformType_Douban;
    } else if ([platformString isEqualToString:@"FACEBOOK"]) {
        return UMSocialPlatformType_Facebook;
    } else if ([platformString isEqualToString:@"FACEBOOK_MESSAGER"]) {
        return UMSocialPlatformType_FaceBookMessenger;
    } else if ([platformString isEqualToString:@"TWITTER"]) {
        return UMSocialPlatformType_Twitter;
    } else if ([platformString isEqualToString:@"YIXIN"]) {
        return UMSocialPlatformType_YixinSession;
    } else if ([platformString isEqualToString:@"YIXIN_CIRCLE"]) {
        return UMSocialPlatformType_YixinTimeLine;
    } else if ([platformString isEqualToString:@"INSTAGRAM"]) {
        return UMSocialPlatformType_Instagram;
    } else if ([platformString isEqualToString:@"PINTEREST"]) {
        return UMSocialPlatformType_Pinterest;
    } else if ([platformString isEqualToString:@"EVERNOTE"]) {
        return UMSocialPlatformType_EverNote;
    } else if ([platformString isEqualToString:@"POCKET"]) {
        return UMSocialPlatformType_Pocket;
    } else if ([platformString isEqualToString:@"LINKEDIN"]) {
        return UMSocialPlatformType_Linkedin;
    } else if ([platformString isEqualToString:@"FOURSQUARE"]) {
        return UMSocialPlatformType_UnKnown; // 如果需要，定义此平台类型
    } else if ([platformString isEqualToString:@"YNOTE"]) {
        return UMSocialPlatformType_UnKnown; // 另定义一个平台类型
    } else if ([platformString isEqualToString:@"WHATSAPP"]) {
        return UMSocialPlatformType_Whatsapp;
    } else if ([platformString isEqualToString:@"LINE"]) {
        return UMSocialPlatformType_Line;
    } else if ([platformString isEqualToString:@"FLICKR"]) {
        return UMSocialPlatformType_Flickr;
    } else if ([platformString isEqualToString:@"TUMBLR"]) {
        return UMSocialPlatformType_Tumblr;
    } else if ([platformString isEqualToString:@"ALIPAY"]) {
        return UMSocialPlatformType_UnKnown; // 如果需要，可以自定义平台
    } else if ([platformString isEqualToString:@"KAKAO"]) {
        return UMSocialPlatformType_KakaoTalk;
    } else if ([platformString isEqualToString:@"BYTEDANCE"]) {
        return UMSocialPlatformType_UnKnown; // 自定义平台
    } else if ([platformString isEqualToString:@"BYTEDANCE_PUBLISH"]) {
        return UMSocialPlatformType_UnKnown;
    } else if ([platformString isEqualToString:@"BYTEDANCE_FRIENDS"]) {
        return UMSocialPlatformType_UnKnown;
    } else if ([platformString isEqualToString:@"DROPBOX"]) {
        return UMSocialPlatformType_DropBox;
    } else if ([platformString isEqualToString:@"VKONTAKTE"]) {
        return UMSocialPlatformType_VKontakte;
    } else if ([platformString isEqualToString:@"DINGTALK"]) {
        return UMSocialPlatformType_DingDing;
    } else if ([platformString isEqualToString:@"HONOR"]) {
        return UMSocialPlatformType_UnKnown; // 未知平台或自定义类型
    } else if ([platformString isEqualToString:@"MORE"]) {
        return UMSocialPlatformType_UnKnown; // "MORE"
        // 可能需要你定义成一个具体的平台类型
    } else {
        return UMSocialPlatformType_UnKnown; // 如果没有匹配到，返回 UnKnown
    }
}

- (void)shareWithText:(NSString *)text
                 icon:(NSString *)icon
                 link:(NSString *)link
                title:(NSString *)title
             platform:(NSInteger)platform
           completion:(UMSocialRequestCompletionHandler)completion {
    UMSocialMessageObject *messageObject =
    [UMSocialMessageObject messageObject];

    if (link.length > 0) {
        UMShareWebpageObject *shareObject =
        [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:icon];
        shareObject.webpageUrl = link;

        messageObject.shareObject = shareObject;
    } else if (icon.length > 0) {
        id img = nil;
        if ([icon hasPrefix:@"http"]) {
            img = icon;
        } else {
            if ([icon hasPrefix:@"/"]) {
                img = [UIImage imageWithContentsOfFile:icon];
            } else {
                img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:icon ofType:nil]];
            }
        }
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        shareObject.thumbImage = img;
        shareObject.shareImage = img;
        messageObject.shareObject = shareObject;

        messageObject.text = text;
    } else if (text.length > 0) {
        messageObject.text = text;
    } else {
        if (completion) {
            completion(nil, [NSError errorWithDomain:@"UShare" code:-3 userInfo:@{@"message" : @"invalid parameter"}]);
            return;
        }
    }

    [[UMSocialManager defaultManager] shareToPlatform:platform
                                        messageObject:messageObject
                                currentViewController:nil
                                           completion:completion];
}

RCT_EXPORT_METHOD(init : (NSDictionary *)platformConfig) {
    if (!platformConfig) {
        NSLog(@"platformConfig is nil");
        return;
    }

    if (platformConfig[@"UMENG"]) {
        NSDictionary *config = platformConfig[@"UMENG"];
        if (config) {
            NSString *appId = config[@"APPID"];
            if (appId) {
                [RNUMConfigure initWithAppkey:appId channel:@"App Store"];
            }
        }
    }

    if (platformConfig[@"WEIXIN"]) {
        NSDictionary *config = platformConfig[@"WEIXIN"];
        if (config) {
            NSString *appId = config[@"APPID"];
            NSString *secret = config[@"SECRET"];
            if (appId && secret) {
                NSLog(@"UMShare WEIXIN appId=%@", appId);
                NSLog(@"UMShare WEIXIN secret=%@", secret);
                // 设置微信的appKey和appSecret
                [[UMSocialManager defaultManager]
                 setPlaform:UMSocialPlatformType_WechatSession
                 appKey:appId
                 appSecret:secret
                 redirectURL:@"http://mobile.umeng.com/social"];

                // 微信、QQ、微博完整版会校验合法的universalLink，不设置会在初始化平台失败,
                // 配置微信Universal Link需注意
                // universalLinkDic的key是rawInt类型，不是枚举类型 ，即为
                // UMSocialPlatformType.wechatSession.rawInt
                // https://blog.csdn.net/qq_40098459/article/details/137148037
                // [UMSocialGlobal shareInstance].universalLinkDic
                // =@{@(UMSocialPlatformType_WechatSession):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/"};

                // 设置 小程序 回调app的回调
                [[UMSocialManager defaultManager]
                 setLauchFromPlatform:(UMSocialPlatformType_WechatSession)
                 completion:^(id userInfoResponse, NSError *error) {
                    NSLog(@"umshare setLauchFromPlatform:userInfoResponse:%@", userInfoResponse);
                }];

                // 移除相应平台的分享，如微信收藏
                [[UMSocialManager defaultManager]
                 removePlatformProviderWithPlatformTypes:@[
                    @(UMSocialPlatformType_WechatFavorite)
                ]];
            }
        }
    }
    if (platformConfig[@"DINGTALK"]) {
        NSDictionary *config = platformConfig[@"DINGTALK"];
        if (config) {
            NSString *appId = config[@"APPID"];
            if (appId) {
                NSLog(@"UMShare DINGTALK appId=%@", appId);
                // 设置钉钉的appKey和appSecret
                [[UMSocialManager defaultManager]
                 setPlaform:UMSocialPlatformType_DingDing
                 appKey:appId
                 appSecret:nil
                 redirectURL:@"http://mobile.umeng.com/social"];
            }
        }
    }

    // 设置分享到QQ互联的appID，U-Share
    // SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    // [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
    // appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil
    // redirectURL:@"http://mobile.umeng.com/social"];

    // 设置新浪的appKey和appSecret
    // [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
    // appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad"
    // redirectURL:@"https://sns.whalecloud.com/sina2/callback"];

    // 打开图片水印
    // [UMSocialGlobal shareInstance].isUsingWaterMark = YES;

    // 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

RCT_EXPORT_METHOD(share
                  : (NSString *)text icon
                  : (NSString *)icon link
                  : (NSString *)link title
                  : (NSString *)title platform
                  : (NSString *)platform completion
                  : (RCTResponseSenderBlock)completion) {
    UMSocialPlatformType plf = [self platformTypeForString:platform];
    if (plf == UMSocialPlatformType_UnKnown) {
        if (completion) {
            completion(@[ @(UMSocialPlatformType_UnKnown), @"invalid platform" ]);
            return;
        }
    }

    [self shareWithText:text
                   icon:icon
                   link:link
                  title:title
               platform:plf
             completion:^(id result, NSError *error) {
        if (completion) {
            if (error) {
                NSString *msg =
                error.userInfo[@"NSLocalizedFailureReason"];
                if (!msg) {
                    msg = error.userInfo[@"message"];
                }
                if (!msg) {
                    msg = @"share failed";
                }
                NSInteger stcode = error.code;
                if (stcode == 2009) {
                    stcode = -1;
                }
                completion(@[ @(stcode), msg ]);
            } else {
                completion(@[ @200, @"share success" ]);
            }
        }
    }];
}

RCT_EXPORT_METHOD(shareboard
                  : (NSString *)text icon
                  : (NSString *)icon link
                  : (NSString *)link title
                  : (NSString *)title platform
                  : (NSArray *)platforms completion
                  : (RCTResponseSenderBlock)completion) {
    NSMutableArray *plfs = [NSMutableArray array];

    // 遍历字符串数组
    for (NSString *platformString in platforms) {
        // 转换每个字符串到对应的枚举类型
        UMSocialPlatformType platformType =
        [self platformTypeForString:platformString];

        // 只有有效的枚举才添加到数组
        if (platformType != UMSocialPlatformType_UnKnown) {
            [plfs addObject:@(platformType)];
        }
    }

    NSLog(@"UMShare shareboard text=%@", text);
    NSLog(@"UMShare shareboard icon=%@", icon);
    NSLog(@"UMShare shareboard link=%@", link);
    NSLog(@"UMShare shareboard title=%@", title);
    NSLog(@"UMShare shareboard platforms=%@", platforms);
    NSLog(@"UMShare shareboard plfs=%@", plfs);
    if (plfs.count > 0) {
        [UMSocialUIManager setPreDefinePlatforms:plfs];
    }
    [UMSocialUIManager
     showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
       [self shareWithText:text
                      icon:icon
                      link:link
                     title:title
                  platform:platformType
                completion:^(id result, NSError *error) {
           if (completion) {
               if (error) {
                   NSString *msg =
                   error.userInfo[@"NSLocalizedFailureReason"];
                   if (!msg) {
                       msg = error.userInfo[@"message"];
                   }
                   if (!msg) {
                       msg = @"share failed";
                   }
                   NSInteger stcode = error.code;
                   if (stcode == 2009) {
                       stcode = -1;
                   }
                   completion(@[ @(stcode), msg ]);
               } else {
                   completion(@[ @200, @"share success" ]);
               }
           }
       }];
   }];
}

RCT_EXPORT_METHOD(auth: (NSString *)platform completion: (RCTResponseSenderBlock)completion) {
    UMSocialPlatformType plf = [self platformTypeForString:platform];
    if (plf == UMSocialPlatformType_UnKnown) {
        if (completion) {
            completion(@[ @(UMSocialPlatformType_UnKnown), @"invalid platform" ]);
            return;
        }
    }

    [[UMSocialManager defaultManager]
     getUserInfoWithPlatform:plf
     currentViewController:nil
     completion:^(id result, NSError *error) {
        if (completion) {
            if (error) {
                NSString *msg =
                error.userInfo[@"NSLocalizedFailureReason"];
                if (!msg) {
                    msg = error.userInfo[@"message"];
                }
                if (!msg) {
                    msg = @"share failed";
                }
                NSInteger stCode = error.code;
                if (stCode == 2009) {
                    stCode = -1;
                }
                completion(@[ @(stCode), @{}, msg ]);
            } else {
                UMSocialUserInfoResponse *authInfo = result;

                NSMutableDictionary *retDict =  [NSMutableDictionary dictionaryWithCapacity:8];
                retDict[@"uid"] = authInfo.uid;
                retDict[@"openid"] = authInfo.openid;
                retDict[@"unionid"] = authInfo.unionId;
                retDict[@"accessToken"] = authInfo.accessToken;
                retDict[@"refreshToken"] = authInfo.refreshToken;
                retDict[@"expiration"] = authInfo.expiration;

                retDict[@"name"] = authInfo.name;
                retDict[@"iconurl"] = authInfo.iconurl;
                retDict[@"gender"] = authInfo.unionGender;

                NSDictionary *originInfo =
                authInfo.originalResponse;
                retDict[@"city"] = originInfo[@"city"];
                retDict[@"province"] = originInfo[@"province"];
                retDict[@"country"] = originInfo[@"country"];

                completion(@[ @200, retDict, @"" ]);
            }
        }
    }];
}
@end
