//
//  XZUDIDGenerator.m
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZUDIDGenerator.h"
#import "XZKeychain.h"

static NSString *serviceName = @"com.xiazer";
static NSString *udidName = @"xiazerMusicUDID";
static NSString *pasteboardType = @"xiazerAppsContent";

typedef NS_ENUM (NSUInteger, RTGroupUDIDType){
    RTGroupUDIDTypeAnjuke,
    RTGroupUDIDTypeBroker
};

@interface XZUDIDGenerator ()
@property (nonatomic, strong) XZKeychain *myKeyChain;

@property (nonatomic, copy, readwrite) NSString *udid;
@property (nonatomic, copy) NSString *appBundleName;

@end

@implementation XZUDIDGenerator

+ (XZUDIDGenerator *)sharedInstance
{
    static dispatch_once_t pred;
    static XZUDIDGenerator *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZUDIDGenerator alloc] init];
    });
    return sharedInstance;
}


- (void)saveUDID:(NSString *)udid
{
    BOOL saveOk = NO;
    NSData *udidData = [self.myKeyChain find:udidName];
    if (udidData == nil) {
        saveOk = [self.myKeyChain insert:udidName data:[self changeStringToData:udid]];
    }else{
        saveOk = [self.myKeyChain update:udidName data:[self changeStringToData:udid]];
    }
    if (!saveOk) {
        [self createPasteBoradValue:udid forIdentifier:udidName];
    }
}

- (NSString *)udid
{
    if (!_udid) {
        _udid = [[self getMyUDID] copy];
    }
    return _udid;
}

#pragma mark -- privite method
- (NSString *)appBundleName
{
    if (!_appBundleName) {
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        NSArray *components = [identifier componentsSeparatedByString:@"."];
        if (components.count > 2) {
            _appBundleName = [components objectAtIndex:2];
        } else {
            _appBundleName = @"";
        }
    }
    return _appBundleName;
}

- (XZKeychain *)myKeyChain
{
    if (!_myKeyChain) {
        _myKeyChain = [[XZKeychain alloc] initWithService:serviceName withGroup:@"com.xiazer.music"];
    }
    return _myKeyChain;
}

- (NSData *)changeStringToData:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)getMyUDID
{
    
    NSData *udidData = [self.myKeyChain find:udidName];
    NSString *udid = nil;
    if (udidData != nil) {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
    if (udid.length == 0) {
        udid = [self readPasteBoradforIdentifier:udidName];
    }
    return udid;
}

- (void)createPasteBoradValue:(NSString *)value forIdentifier:(NSString *)identifier
{
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:serviceName create:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:value forKey:identifier];
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [pb setData:dictData forPasteboardType:pasteboardType];
}

- (NSString *)readPasteBoradforIdentifier:(NSString *)identifier
{
    
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:serviceName create:YES];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[pb dataForPasteboardType:pasteboardType]];
    return [dict objectForKey:identifier];
}
@end
