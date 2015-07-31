//
//  MSStringSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSStringSettingItem.h"

@implementation MSStringSettingItem

@synthesize value = _value;

+(MSStringSettingItem *)instanceWithKey:(NSString *)key value:(NSString*)value
{
    MSStringSettingItem *instance = [[MSStringSettingItem alloc] init];
    instance->_key = key;
    instance->_value = value;
    instance->_isNull = NO;
    
    return instance;
}

-(void)fromJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSString class]]) {
        return;
    }
    _isNull = NO;
    NSString *string = (NSString*)jsonObject;
    _value = string;
}

-(id)toJSONObject
{
    return _value;
}

-(void)setValue:(NSString *)value
{
    _isNull = !value;
    _value = value;
}
-(NSString *)value
{
    return _value;
}

@end
