//
//  MSIntegerSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 10.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

/**
 Represents integer setting item with max and min value
 */
@interface MSIntegerSettingItem : MSSettingItem
{
    NSUInteger _minValue, _maxValue;
}

@property (nonatomic) NSUInteger value;

/**
 Initializes a new setting item with value set
 */
-(id)initWithKey:(NSString*)key
           value:(NSUInteger)value
        minValue:(NSUInteger)minValue
        maxValue:(NSUInteger)maxValue;
/**
 Creates a new setting item with value set
 */
+(MSIntegerSettingItem*)instanceWithKey:(NSString*)key
                                  value:(NSUInteger)value
                               minValue:(NSUInteger)minValue
                               maxValue:(NSUInteger)maxValue;


/**
 Initializes a new setting item with no value
 */
-(id)initWithKey:(NSString*)key
        minValue:(NSUInteger)minValue
        maxValue:(NSUInteger)maxValue;

/**
 Creates a new setting item with no value
 */
+(MSIntegerSettingItem*)instanceWithKey:(NSString*)key
                               minValue:(NSUInteger)minValue
                               maxValue:(NSUInteger)maxValue;

@end
