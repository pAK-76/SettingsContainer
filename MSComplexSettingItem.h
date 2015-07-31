//
//  MSComplexSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 09.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

/**
 Represents Setting Item, containing other setting items
 */
@interface MSComplexSettingItem : MSSettingItem
{
    NSArray *_items;
}

@end
