//
//  BooleanSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 08.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSBooleanSettingItem.h"

@implementation MSBooleanSettingItem

+(MSBooleanSettingItem *)instanceWithKey:(NSString *)key value:(BOOL)value
{
    MSBooleanSettingItem *instance = [[MSBooleanSettingItem alloc] init];
    instance->_key = key;
    instance->_value = value;
    instance->_isNull = NO;
    
    return instance;
}

-(void)setValue:(BOOL)value
{
    _value = value;
    _isNull = NO;
}

-(void)fromJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSNumber class]]) {
        NSLog(@"Value for key %@ is not NSNumber", _key);
        return;
    }
    NSNumber *number = (NSNumber*)jsonObject;
    _value = [number boolValue];
}

-(id)toJSONObject
{
    return [NSNumber numberWithBool:_value];
}

@end
