//
//  MSRectSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 24/07/14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSRectSettingItem.h"

@implementation MSRectSettingItem
@synthesize value = _value;

-(id)initWithKey:(NSString *)key value:(NSRect)rect
{
    self = [super initWithKey:key];
    if (self) {
        _isNull = NO;
        _value = rect;
    }
    
    return self;
}

+(MSRectSettingItem *)instanceWithKey:(NSString *)key value:(NSRect)value
{
    return [[MSRectSettingItem alloc] initWithKey:key value:value];
}

-(void)setValue:(NSRect)value
{
    _value = value;
    _isNull = NO;
}
-(NSRect)value
{
    return _isNull ? NSZeroRect : _value;
}

-(id)toJSONObject
{
    return @{@"origin": @{
                     @"x": @(_value.origin.x),
                     @"y": @(_value.origin.y)
                     },
             @"size": @{
                     @"width": @(_value.size.width),
                     @"height": @(_value.size.height)
                        }
             };
}
-(void)fromJSONObject:(id)jsonObject
{
    NSDictionary *rectObj = (NSDictionary*)jsonObject;
    @try {
        NSDictionary *origin = rectObj[@"origin"];
        NSDictionary *size = rectObj[@"size"];
        _value = NSMakeRect([origin[@"x"] intValue], [origin[@"y"] intValue], [size[@"width"] intValue], [size[@"height"] intValue]);
        _isNull = NO;
    }
    @catch (NSException *exception) {
        NSLog(@"Rect setting for key %@ is invalid: %@", _key, rectObj);
    }
}

@end
