
//
//  MSHotkeySettingItem.m
//  Monosnap
//
//  Created by Павел Аксенкин on 10.07.14.
//  Copyright (c) 2014 Monosnap. All rights reserved.
//

#import "MSHotkeySettingItem.h"

@implementation MSHotkey

/* Public constants */
unsigned short kMSHotkeyCode5 = 23;
unsigned short kMSHotkeyCode6 = 22;
unsigned short kMSHotkeyCode7 = 26;
unsigned short kMSHotkeyCode8 = 28;
unsigned short kMSHotkeyCode9 = 25;
unsigned short kMSHotkeyCode0 = 29;


/* Private constants */

NSString * const kMSHotkeyCodeKey = @"Code";
NSString * const kMSHotkeyMaskKey = @"Mask";
NSString * const kMSHotkeyCharsKey = @"Characters";
NSString * const kMSHotkeyActiveKey = @"Active";

+(MSHotkey *)instanceWithKey:(NSString *)key
                        code:(unsigned short)code
                        mask:(NSInteger)mask
                  characters:(NSString *)characters
{
    return [[self alloc] initWithKey:key code:code characters:characters andMask:mask];
}

-(id)initWithKey:(NSString *)key
{
    self = [super initWithKey:key];
    if (self) {
        // For some reasons we need _isNull always set to NO: we need to save disabled hotkey which is enabled by default
        _isNull = NO;
        _key = key;
        _isActive = NO;
    }
    
    return self;
}

-(id)initWithKey:(NSString *)key
            code:(unsigned short)code
      characters:(NSString *)characters
         andMask:(NSInteger)mask
{
    self = [super initWithKey:key];
    if (self) {
        _isNull = NO;
        _key = key;
        _mask = mask;
        _code = code;
        _characters = characters;
        _isActive = YES;
    }
    
    return self;
}

-(id)toJSONObject
{
    if (_isNull) return nil;
    
    NSDictionary *jsonObject;
    if (_isActive) {
        jsonObject = @{
                       kMSHotkeyCodeKey: [NSNumber numberWithUnsignedShort:_code],
                       kMSHotkeyMaskKey: [NSNumber numberWithUnsignedInteger:_mask],
                       kMSHotkeyCharsKey: _characters,
                       kMSHotkeyActiveKey: [NSNumber numberWithBool:YES]
                       };
    } else {
        jsonObject = @{
                       kMSHotkeyActiveKey: [NSNumber numberWithBool:NO]
                       };
    }
    
    return jsonObject;
}

-(void)fromJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Settings Error: Invalid hotkey json for key %@", _key);
        return;
    }
    NSDictionary *dict = (NSDictionary*)jsonObject;
    if (![dict objectForKey:kMSHotkeyActiveKey]) {
        NSLog(@"Settings Error: JSON for hotkey %@ has no isActive", _key);
        return;
    }
    if (![[dict objectForKey:kMSHotkeyActiveKey] isKindOfClass:[NSNumber class]]) {
        NSLog(@"Setting Error: JSON for hotkey %@ has invalid isActive %@", _key, [dict objectForKey:kMSHotkeyActiveKey]);
        return;
    }
    BOOL isActive = [[dict objectForKey:kMSHotkeyActiveKey] boolValue];
    if (isActive) {
        if (![dict objectForKey:kMSHotkeyCodeKey]) {
            NSLog(@"Settings Error: JSON for hotkey %@ has no Code", _key);
            return;
        }
        if (![[dict objectForKey:kMSHotkeyCodeKey] isKindOfClass:[NSNumber class]]) {
            NSLog(@"Setting Error: JSON for hotkey %@ has invalid Code %@", _key, [dict objectForKey:kMSHotkeyCodeKey]);
            return;
        }
        
        if (![dict objectForKey:kMSHotkeyMaskKey]) {
            NSLog(@"Settings Error: JSON for hotkey %@ has no Mask", _key);
            return;
        }
        if (![[dict objectForKey:kMSHotkeyMaskKey] isKindOfClass:[NSNumber class]]) {
            NSLog(@"Setting Error: JSON for hotkey %@ has invalid Mask %@", _key, [dict objectForKey:kMSHotkeyMaskKey]);
            return;
        }
        
        if (![dict objectForKey:kMSHotkeyCharsKey]) {
            NSLog(@"Settings Error: JSON for hotkey %@ has no Characters", _key);
            return;
        }
        if (![[dict objectForKey:kMSHotkeyCharsKey] isKindOfClass:[NSString class]]) {
            NSLog(@"Setting Error: JSON for hotkey %@ has invalid Characters %@", _key, [dict objectForKey:kMSHotkeyCharsKey]);
            return;
        }
        
        _isNull = NO;
        _code = [[dict objectForKey:kMSHotkeyCodeKey] unsignedShortValue];
        _mask = [[dict objectForKey:kMSHotkeyMaskKey] unsignedIntegerValue];
        _characters = [dict objectForKey:kMSHotkeyCharsKey];
        _isActive = YES;
    } else {
        _isNull = NO;
        _isActive = NO;
    }
}

#pragma mark Retrieving string representation

-(NSString *)stringRepresentation
{
    NSMutableArray *charList = [NSMutableArray array];
    if (_mask & NSCommandKeyMask) {
        [charList addObject:@"⌘"];
    } if (_mask & NSControlKeyMask) {
        [charList addObject:@"⌃"];
    } if (_mask & NSShiftKeyMask) {
        [charList addObject:@"⇧"];
    } if (_mask & NSAlternateKeyMask) {
        [charList addObject:@"⌥"];
    }
    [charList addObject:_characters];
    
    return [charList componentsJoinedByString:@"+"];
}

+(NSString*)charactersCleanse:(NSString*)oldCharacters andCode:(unsigned short)code
{
    NSDictionary *ReplaceDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"↩", @36,
                                       @"⌫", @51,
                                       @"←", @123,
                                       @"→", @124,
                                       @"↑", @126,
                                       @"↓", @125,
                                       @"0", @29,
                                       @"1", @18,
                                       @"2", @19,
                                       @"3", @20,
                                       @"4", @21,
                                       @"5", @23,
                                       @"6", @22,
                                       @"7", @26,
                                       @"8", @28,
                                       @"9", @25,
                                       nil];
    
    NSString *result = oldCharacters;
    if ([ReplaceDictionary objectForKey:[NSNumber numberWithUnsignedShort:code]]) {
        result = [ReplaceDictionary objectForKey:[NSNumber numberWithUnsignedShort:code]];
    }
    
    return result;
}

@end
