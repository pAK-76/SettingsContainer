//
//  MSStringSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

@interface MSStringSettingItem : MSSettingItem

@property (retain, nonatomic) NSString* value;

+(MSStringSettingItem*)instanceWithKey:(NSString*)key value:(NSString*)value;

@end
