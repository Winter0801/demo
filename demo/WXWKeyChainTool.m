//
//  WXWKeyChainTool.m
//  controlApp
//
//  Created by Horizoom on 16/1/20.
//  Copyright © 2016年 Horizoom. All rights reserved.
//

#import "WXWKeyChainTool.h"

#import "SSKeychain.h"

#define  keychain_service @"EB"
#define  keychain_account @"custom"

@implementation WXWKeyChainTool

- (NSString *)getUUID{
    
    NSError * error;
    NSString *strUUID=[SSKeychain passwordForService:keychain_service account:keychain_account];
    
    if (strUUID==nil||[strUUID isEqualToString:@"" ]||strUUID.length==0)
    {
        strUUID=[self get_uuid] ;
        BOOL  succcess=   [SSKeychain setPassword:strUUID forService:keychain_service account:keychain_account  error:&error];
        if(succcess)
        {
            NSLog(@"keychain success ");
        }
    }
    return strUUID;
    
}

- (NSString*)get_uuid{
    
    CFUUIDRef uuid_ref=CFUUIDCreate(nil);
    CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid=[NSString stringWithString:(__bridge NSString *)(uuid_string_ref)];
    CFRelease(uuid_string_ref);
    return uuid;
 
}

@end
