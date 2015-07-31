//
//  MSColorSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 16.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

/**
 Represents color setting item. Can't store alpha!
 */
@interface MSColorSettingItem : MSSettingItem

@property (retain, nonatomic) NSColor *value;

-(id)initWithKey:(NSString *)key value:(NSColor*)color;
+(MSColorSettingItem*)instanceWithKey:(NSString*)key value:(NSColor*)value;

@end
