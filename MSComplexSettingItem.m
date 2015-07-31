//
//  MSComplexSettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSComplexSettingItem.h"

@implementation MSComplexSettingItem

-(id)toJSONObject
{
    if (_isNull) {
        UPALog(@"Settings Error: someone trying to flush setting with isNull = True");
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (MSSettingItem *item in _items) {
        if (!item) {
            UALog(@"Settings Error! Setting for key %@ contains nil settings", _key);
            continue;
        }
        if (item.isNull) {
            continue;   // That's OK, some settings may be NULL on purpose
        }
        id jsonObject = [item toJSONObject];
        if (!jsonObject) {
            UALog(@"Settings Error! Cannot serialize setting %@ for key %@ in setting %@", item, item.key, self);
        }
        [dic setObject:jsonObject forKey:item.key];
    }
    
    return dic;
}

-(void)fromJSONObject:(id)jsonObject
{
    _isNull = NO;
    for(NSString *key in jsonObject) {
        id jsonValue = jsonObject[key];
        for (MSSettingItem *item in _items) {
            if ([key isEqualTo:item.key]) {
                [item fromJSONObject:jsonValue];
                break;
            }
            // If corresponding setting not found => Probably the older version have no idea about new settings
        }
    }
}

@end
