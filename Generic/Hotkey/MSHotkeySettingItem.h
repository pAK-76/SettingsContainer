//
//  MSHotkeySettingItem.h
//  Monosnap
//
//  Created by Павел Аксенкин on 10.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSSettingItem.h"

extern unsigned short kMSHotkeyCode5;
extern unsigned short kMSHotkeyCode6;
extern unsigned short kMSHotkeyCode7;
extern unsigned short kMSHotkeyCode8;
extern unsigned short kMSHotkeyCode9;
extern unsigned short kMSHotkeyCode0;

@interface MSHotkey: MSSettingItem

@property NSUInteger mask;
@property unsigned short code;
@property (retain) NSString *characters;
@property BOOL isActive;

@property (copy) void (^action)(NSEvent *hkEvent);

-(id)initWithKey:(NSString *)key
            code:(unsigned short)code
      characters:(NSString*)characters
         andMask:(NSInteger)mask;

+(MSHotkey*)instanceWithKey:(NSString *)key
                       code:(unsigned short)code
                       mask:(NSInteger)mask
                 characters:(NSString *)characters;

-(NSString*)stringRepresentation;
+(NSString*)charactersCleanse:(NSString*)oldCharacters andCode:(unsigned short)code;

@end
