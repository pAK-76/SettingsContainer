//
//  MSColorSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 16.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSColorSettingItem.h"

#import "NSColor+Monosnap.h"

@implementation MSColorSettingItem

@synthesize value = _value;

-(id)initWithKey:(NSString *)key value:(NSColor *)color
{
    self = [super initWithKey:key];
    if (self) {
        _isNull = NO;
        _value = color;
    }
    
    return self;
}

-(void)setValue:(NSColor *)value
{
    _value = value;
    _isNull = NO;
}

+(MSColorSettingItem *)instanceWithKey:(NSString *)key value:(NSColor *)value
{
    return [[MSColorSettingItem alloc] initWithKey:key value:value];
}

-(id)toJSONObject
{
    return [_value RGBString];
}
-(void)fromJSONObject:(id)jsonObject
{
    NSString *colorString = (NSString*)jsonObject;
    @try {
        _value = [NSColor colorFromRGBString:colorString];
    }
    @catch (NSException *exception) {
        NSLog(@"Color setting for key %@ is invalid: %@", _key, colorString);
    }
}

@end
