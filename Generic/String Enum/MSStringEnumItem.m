//
//  MSStringEnumItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSStringEnumItem.h"

@implementation MSStringEnumItem

@synthesize value = _value;

+(MSStringEnumItem *)instanceWithKey:(NSString *)key value:(NSString*)value valueList:(NSArray *)list
{
    if ([list indexOfObject:value] == NSNotFound) {
        return nil;
    }
    
    MSStringEnumItem *instance = [[MSStringEnumItem alloc] init];
    instance->_key = key;
    instance->_value = value;
    instance->_isNull = NO;
    instance->_valueList = list;
    
    return instance;
}

-(void)fromJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *string = (NSString*)jsonObject;
    if ([_valueList indexOfObject:string] == NSNotFound) {
        return; // Do not change the value to an unknown
    }
    _isNull = NO;
    _value = string;
}

-(id)toJSONObject
{
    return _value;
}

-(void)setValue:(NSString *)value
{
    if (!value || [_valueList indexOfObject:value] == NSNotFound) {
        NSLog(@"Forbidden value %@ for key %@", value, _key);
        return;
    }
    _value = value;
}
-(NSString *)value
{
    return _value;
}


@end
