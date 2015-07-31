
//
//  MSDoubleSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 16.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSDoubleSettingItem.h"

@implementation MSDoubleSettingItem

-(id)initWithKey:(NSString *)key value:(CGFloat)value
{
    self = [super initWithKey:key];
    if (self) {
        _isNull = NO;
        _value = value;
    }
    
    return self;
}
+(MSDoubleSettingItem *)instanceWithKey:(NSString *)key value:(CGFloat)value
{
    return [[MSDoubleSettingItem alloc] initWithKey:key value:value];
}

-(id)toJSONObject
{
    return [NSNumber numberWithDouble:_value];
}
-(void)fromJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSNumber class]]) {
        NSLog(@"Value for key %@ is not NSNumber", _key);
        return;
    }
    NSNumber *number = (NSNumber*)jsonObject;
    _value = [number doubleValue];
}



@end
