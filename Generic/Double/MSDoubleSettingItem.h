//
//  MSDoubleSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 16.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

/**
 Represents double setting item
 */
@interface MSDoubleSettingItem : MSSettingItem

@property CGFloat value;

-(id)initWithKey:(NSString *)key value:(CGFloat)value;
+(MSDoubleSettingItem*)instanceWithKey:(NSString*)key value:(CGFloat)value;

@end
