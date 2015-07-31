//
//  MSRectSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 24/07/14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

/**
 Represents rectangle setting item.
 */
@interface MSRectSettingItem : MSSettingItem

@property (nonatomic) NSRect value;

-(id)initWithKey:(NSString *)key value:(NSRect)rect;
+(MSRectSettingItem*)instanceWithKey:(NSString*)key value:(NSRect)value;

@end
