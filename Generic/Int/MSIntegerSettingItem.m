//
//  MSIntegerSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 10.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSIntegerSettingItem.h"

@implementation MSIntegerSettingItem

@synthesize value = _value;

#pragma mark Constructors

-(id)initWithKey:(NSString *)key
{
    self = [super initWithKey:key];
    if (self) {
        _minValue = 0;
        _maxValue = NSUIntegerMax;
    }
    
    return self;
}

-(id)initWithKey:(NSString *)key
           value:(NSUInteger)value
        minValue:(NSUInteger)minValue
        maxValue:(NSUInteger)maxValue
{
    if (value < minValue || value > maxValue) {
        NSLog(@"Error! You are giving invalid value %ld for setting key %@", value, key);
        return nil;
    }
    
    self = [super initWithKey:key];
    if (self) {
        _isNull = NO;
        _value = value;
        _minValue = minValue;
        _maxValue = maxValue;
    }
    
    return self;
}

+(MSIntegerSettingItem *)instanceWithKey:(NSString *)key
                                   value:(NSUInteger)value
                                minValue:(NSUInteger)minValue
                                maxValue:(NSUInteger)maxValue
{
    return [[self alloc] initWithKey:key value:value minValue:minValue maxValue:maxValue];
}

-(id)initWithKey:(NSString *)key minValue:(NSUInteger)minValue maxValue:(NSUInteger)maxValue
{
    self = [super initWithKey:key];
    if (self) {
        _minValue = minValue;
        _maxValue = maxValue;
    }
    
    return self;
}

+(MSIntegerSettingItem *)instanceWithKey:(NSString *)key minValue:(NSUInteger)minValue maxValue:(NSUInteger)maxValue
{
    return [[self alloc] initWithKey:key minValue:minValue maxValue:maxValue];
}

#pragma mark Properties

-(void)setValue:(NSUInteger)value
{
    if (value < _minValue || value > _maxValue) {
        NSLog(@"Wrong value %lu for key %@", value, _key);
        return;
    }
    
    _isNull = NO;
    _value = value;
}
-(NSUInteger)value
{
    return _value;
}

#pragma mark MSSettingItem protocol

-(id)toJSONObject
{
    return [NSNumber numberWithInteger:self.value];
}

-(void)fromJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSNumber class]]) {
        NSLog(@"Value for key %@ is not NSNumber", _key);
        return;
    }
    NSNumber *number = (NSNumber*)jsonObject;
    self.value = [number integerValue];
}

@end
