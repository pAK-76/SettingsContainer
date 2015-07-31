//
//  MSSecureSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 10.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSecureSettingItem.h"
#import "EMSKeychainItem.h"

@implementation MSSecureSettingItem

#pragma mark Constructors

+(MSSecureSettingItem *)instanceWithKey:(NSString *)key serviceName:(NSString *)serviceName
{
    return [[self alloc] initWithKey:key serviceName:serviceName];
}

-(id)initWithKey:(NSString *)key serviceName:(NSString *)serviceName
{
    self = [super initWithKey:key];
    if (self) {
        _serviceName = serviceName;
        _userName = [MSStringSettingItem instanceWithKey:@"User Name"];
        
        _items = @[_userName];
    }
    
    return self;
}

#pragma mark properties

-(NSString *)userName
{
    return _userName.value;
}
-(void)setUserName:(NSString *)userName
{
    if ([userName isEqualToString:_userName.value]) return;
    
    if (!_isNull) {
            // Change of the name leads to changing Keychain Item. Remove it with old userName
        [self removePassword];
    }
    _userName.value = userName;
    
    if (_password && _password.length > 0) {
            // Change of the name leads to changing Keychain Item. Store it with new userName...
        [self storePassword];
    } else {
            // Or try to restore it, if there is no password.
        [self restorePassword];
    }
    _isNull = ! (userName && userName.length > 0);
}

-(NSString *)password
{
    return _password;
}
-(void)setPassword:(NSString *)password
{
    if ([password isEqualToString:_password]) return;
    
    _password = password;
    if (_password && _password.length > 0) {
        [self storePassword];
    } else {
        [self removePassword];
    }
}

#pragma mark MSSettingItem protocol

-(id)toJSONObject
{
    id result = [super toJSONObject];
    if (!result) return nil;
    
    // Before returning anything as JSON, don't forget to save your password to keychain
    [self storePassword];
    return result;
}

-(void)fromJSONObject:(id)jsonObject
{
    [super fromJSONObject:jsonObject];
    _isNull = NO;
    [self restorePassword];
}

#pragma mark MSSecureItemProtocol

-(void)storePassword
{
    if (_userName.value && _userName.value.length > 0 && _password && _password.length > 0) {
        EMSGenericKeychainItem *item = [EMSGenericKeychainItem genericKeychainItemForService:_serviceName withUsername:_userName.value];
        if (!item) {
            item = [EMSGenericKeychainItem addGenericKeychainItemForService:_serviceName withUsername:_userName.value password:_password];
        } else {
            [item setPassword:_password];
        }
    }
}

-(void)restorePassword
{
    EMSGenericKeychainItem *item = [EMSGenericKeychainItem genericKeychainItemForService:_serviceName withUsername:_userName.value];
    if (item) {
        _password = item.password;
    }
}

-(void)removePassword
{
    EMSGenericKeychainItem *item = [EMSGenericKeychainItem genericKeychainItemForService:_serviceName withUsername:_userName.value];
    [item removeFromKeychain];
}

@end


@implementation MSInternetSecureSettingItem

#pragma mark Constructors
+(MSInternetSecureSettingItem *)instanceWithKey:(NSString *)key protocol:(SecProtocolType)protocol
{
    return [[self alloc] initWithKey:key protocol:protocol];
}

-(id)initWithKey:(NSString *)key protocol:(SecProtocolType)protocol
{
    self = [super initWithKey:key];
    if (self) {
        _protocol = protocol;
        _host = [MSStringSettingItem instanceWithKey:@"Host"];
        _port = [MSIntegerSettingItem instanceWithKey:@"Port" minValue:0 maxValue:65535];
        _dir = [MSStringSettingItem instanceWithKey:@"Directory"];
        _userName = [MSStringSettingItem instanceWithKey:@"User Name"];
        
        _items = @[_host, _port, _dir, _userName];
    }
    
    return self;
}
#pragma mark properties
-(NSString *)host
{
    return _host.value;
}
-(void)setHost:(NSString *)host
{
    if ([host isEqualToString:_host.value]) return;
    
    if (!_isNull) {
        // Change of the host leads to changing Keychain Item. Remove it with old host
        [self removePassword];
    }
    _host.value = host;
    
    if (_password && _password.length > 0) {
        // Change of the host leads to changing Keychain Item. Store it with new host...
        [self storePassword];
    } else {
        // Or try to restore it, if there is no password.
        [self restorePassword];
    }
    _isNull = NO;
}

-(NSUInteger)port
{
    return _port.value;
}
-(void)setPort:(NSUInteger)port
{
    if (port == _port.value) return;
    
    if (!_isNull) {
        // Change of the port leads to changing Keychain Item. Remove it with old port
        [self removePassword];
    }
    _port.value = port;
    if (!port) {
        _port.isNull = NO;
    }
    
    if (_password && _password.length > 0) {
        // Change of the port leads to changing Keychain Item. Store it with new port...
        [self storePassword];
    } else {
        // Or try to restore it, if there is no password.
        [self restorePassword];
    }
}

-(NSString *)dir
{
    return _dir.value;
}
-(void)setDir:(NSString *)dir
{
    if ([dir isEqualToString:_dir.value]) return;
    
    if (!_isNull) {
        // Change of the dir leads to changing Keychain Item. Remove it with old dir
        [self removePassword];
    }
    _dir.value = dir;
    
    if (_password && _password.length > 0) {
        // Change of the dir leads to changing Keychain Item. Store it with new dir...
        [self storePassword];
    } else {
        // Or try to restore it, if there is no password.
        [self restorePassword];
    }
}

-(NSString *)userName
{
    return _userName.value;
}
-(void)setUserName:(NSString *)userName
{
    if ([userName isEqualToString:_userName.value]) return;
    
    if (!_isNull) {
        // Change of the name leads to changing Keychain Item. Remove it with old userName
        [self removePassword];
    }
    _userName.value = userName;
    
    if (_password && _password.length > 0) {
        // Change of the name leads to changing Keychain Item. Store it with new userName...
        [self storePassword];
    } else {
        // Or try to restore it, if there is no password.
        [self restorePassword];
    }
    _isNull = NO;
}

-(NSString *)password
{
    return _password;
}
-(void)setPassword:(NSString *)password
{
    if ([password isEqualToString:_password]) return;
    
    _password = password;
    if (_password && _password.length > 0) {
        [self storePassword];
    } else {
        [self removePassword];
    }
}

#pragma mark MSSettingItemProtocol
-(id)toJSONObject
{
    id result = [super toJSONObject];
    if (!result) return nil;
    
    // Before returning anything as JSON, don't forget to save your password to keychain
    [self storePassword];
    return result;
}

-(void)fromJSONObject:(id)jsonObject
{
    [super fromJSONObject:jsonObject];
    _isNull = NO;
    [self restorePassword];
}

#pragma mark MSSecureItemProtocol

-(void)storePassword
{
    if (_host.isNull || _userName.isNull || !_password) return;
    EMSInternetKeychainItem *item = [EMSInternetKeychainItem internetKeychainItemForServer:_host.value withUsername:_userName.value path:_dir.value port:_port.value protocol:_protocol];
    if (item) {
        [item setPassword:_password];
    } else {
        item = [EMSInternetKeychainItem addInternetKeychainItemForServer:_host.value withUsername:_userName.value password:_password path:_dir.value port:_port.value protocol:_protocol];
    }
}

-(void)restorePassword
{
    EMSInternetKeychainItem *item = [EMSInternetKeychainItem internetKeychainItemForServer:_host.value withUsername:_userName.value path:_dir.value port:_port.value protocol:_protocol];
    if (item) {
        _password = [item password];
    }
}

-(void)removePassword
{
    EMSInternetKeychainItem *item = [EMSInternetKeychainItem internetKeychainItemForServer:_host.value withUsername:_userName.value path:_dir.value port:_port.value protocol:_protocol];
    [item removeFromKeychain];
}

@end
