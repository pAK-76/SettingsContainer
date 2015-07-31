//
//  MSSecureSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 10.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSComplexSettingItem.h"
#import "MSStringSettingItem.h"
#import "MSIntegerSettingItem.h"

/**
 Represents secure setting item, which should be stored not in JSON, but in System Keychain
 */
@interface MSSecureSettingItem : MSComplexSettingItem
{
    NSString *_serviceName;
    MSStringSettingItem *_userName;
    NSString *_password;
}

/**
 Name of the user in selected service. Acts like the second part of the key in saving password.
 */
@property (retain, nonatomic) NSString *userName;
/**
 Secure part. Must be stored in keychain.
 */
@property (retain, nonatomic) NSString *password;

/**
 Initializes empty (isNull=YES) secure item with set serviceName and key
 */
-(id)initWithKey:(NSString *)key serviceName:(NSString*)serviceName;
/**
 Creates a new empty (isNull=YES) instance of secure setting item with serviceName and key set
 */
+(MSSecureSettingItem*)instanceWithKey:(NSString *)key serviceName:(NSString*)serviceName;

@end



/**
 Represents internet secure setting item, which should be stored not in JSON, but in System Keychain
 Offers sharing to and from other apps (like web browser) by host+port+directory+username+protocol tuple
 */
@interface MSInternetSecureSettingItem : MSComplexSettingItem
{
    SecProtocolType _protocol;
    MSStringSettingItem *_host;
    MSIntegerSettingItem *_port;
    MSStringSettingItem *_dir;
    MSStringSettingItem *_userName;
    NSString *_password;
}

/**
 Internet protocol. Is a part of key tuple for storing password.
 */
@property (readonly) SecProtocolType protocol;
/**
 Address (IP or domain). Is a part of key tuple for storing password.
 */
@property (retain, nonatomic) NSString *host;
/**
 Port. Is a part of key tuple for storing password.
 */
@property (nonatomic) NSUInteger port;
/**
 Path at specified address. Is a part of key tuple for storing password;
 */
@property (retain, nonatomic) NSString *dir;
/**
 Username at the given internet service. Is a part of key tuple for storing password;
 */
@property (retain, nonatomic) NSString *userName;
/**
 Secure part. Must be stored in keychain.
 */
@property (retain, nonatomic) NSString *password;

/**
 Initializes empty (isNull=YES) secure item with set protocol and key
 */
-(id)initWithKey:(NSString *)key protocol:(SecProtocolType)protocol;
/**
 Creates a new empty (isNull=YES) instance of secure setting item with protocol and key set
 */
+(MSInternetSecureSettingItem*)instanceWithKey:(NSString *)key protocol:(SecProtocolType)protocol;

@end
