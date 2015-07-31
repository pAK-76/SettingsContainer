//
//  MSSettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 08.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

@implementation MSSettingItem

@synthesize key = _key;
@synthesize isNull = _isNull;

+(id)instanceWithKey:(NSString *)key
{
    return [[self alloc] initWithKey:key];
}

-(id)initWithKey:(NSString *)key
{
    self = [super init];
    if (self) {
        _key = key;
        _isNull = YES;
    }
    
    return self;
}

-(id)toJSONObject
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(void)fromJSONObject:(id)jsonObject
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end