//
//  BooleanSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 08.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSettingItem.h"


/**
 Represents Setting Item containing only boolean value (YES or NO)
 */
@interface MSBooleanSettingItem : MSSettingItem

@property (nonatomic) BOOL value;

+(MSBooleanSettingItem*)instanceWithKey:(NSString*)key value:(BOOL)value;

@end
