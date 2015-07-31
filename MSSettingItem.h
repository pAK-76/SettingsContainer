//
//  MSSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 08.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides common interface for different setting
 */
@interface MSSettingItem : NSObject
{
    NSString *_key;
    BOOL _isNull;
}

@property (retain, readonly) NSString* key;
@property BOOL isNull;

/** 
 Creates a new instance of setting item representing default setting
 
 @return Setting Item with isNull=YES
 */
+(id)instanceWithKey:(NSString*)key;

/**
 Initializes a new instance of setting item representing default setting
 
 @return Setting Item
 */
-(id)initWithKey:(NSString*)key;

/**
 
 Serializes setting item into JSON Object (NSDictionary* / NSArray* / NSNumber* / NSString*)
 
 @return JSON representation of setting item
 */
-(id)toJSONObject;
/**
 Retrieves data from JSON object
 
 @param jsonObject JSON representation of setting item. Must have one of this types: (NSDictionary* / NSArray* / NSNumber* / NSString*)
 */
-(void)fromJSONObject:(id)jsonObject;

@end
