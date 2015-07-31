//
//  MSStringEnumItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

@interface MSStringEnumItem : MSSettingItem
{
    NSArray *_valueList;
}

@property (retain, nonatomic) NSString* value;

+(MSStringEnumItem*)instanceWithKey:(NSString*)key value:(NSString*)value valueList:(NSArray*)list;

@end
