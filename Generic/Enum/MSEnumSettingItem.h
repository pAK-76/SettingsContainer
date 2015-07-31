//
//  MSEnumSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

@interface MSEnumSettingItem : MSSettingItem
{
    unsigned char _minValue, _maxValue;
}

@property (nonatomic) unsigned char value;

+(MSEnumSettingItem*)instanceWithKey:(NSString*)key
                               value:(unsigned char)value
                            minValue:(unsigned char)minValue
                            maxValue:(unsigned char)maxValue;

@end
