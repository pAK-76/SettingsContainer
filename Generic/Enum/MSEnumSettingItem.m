//
//  MSEnumSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSEnumSettingItem.h"

@implementation MSEnumSettingItem

@synthesize value = _value;

+(MSEnumSettingItem *)instanceWithKey:(NSString *)key
                                value:(unsigned char)value
                             minValue:(unsigned char)minValue
                             maxValue:(unsigned char)maxValue
{
    if (value < minValue || value > maxValue) {
        NSLog(@"Error! You are giving invalid value %u for setting key %@", value, key);
        return nil;
    }
    
    MSEnumSettingItem *instance = [super instanceWithKey:key];
    
    if (instance) {
        instance->_isNull = NO;
        instance->_value = value;
        instance->_minValue = minValue;
        instance->_maxValue = maxValue;
    }
    
    return instance;
}

-(void)setValue:(unsigned char)value
{
    if (value < _minValue || value > _maxValue) {
        return;
    }
    
    _isNull = NO;
    _value = value;
}
-(unsigned char)value
{
    return _value;
}

-(id)toJSONObject
{
    return [NSNumber numberWithUnsignedChar:_value];
}

-(void)fromJSONObject:(id)jsonObject
{
    [self setValue:[jsonObject unsignedCharValue]];
}

@end
