# SettingsContainer
This library provides a way to store complex data in JSON format and access it as a native Objective C Object. It is used in Monosnap application for OS X, for convenient preferences storage. 

`MSSettingItem` class is an abstract setting item with no real data in it. It provides basic functions:
* `+(id)instanceWithKey:(NSString*)key;`   — Used to initialize settings object using JSON key
* `@property BOOL isNull;`                 — If this setting is set
* `-(id)toJSONObject;`                     — Encode the setting to JSON object
* `-(void)fromJSONObject:(id)jsonObject;`  — Decode data from JSON object

`MSComplexSettingItem` is a class to store multiple settings for one key. It helps to group your setting and produces hierarchy so the resulting JSON is easy to read.
In subclass's constructor you should fill `_items` array with `MSSettingItem`'s so ther're encoded into resulting JSON. For example:
```
_filenameTemplate = [MSStringSettingItem instanceWithKey:@"Filename Template"
                                                        value:@"%W %Y-%m-%d %H-%M-%S"];
_applyTemplateToOpenedFiles = [MSBooleanSettingItem instanceWithKey:@"Apply template to opened files" value:NO];
_items = @[
          _filenameTemplate,
          _applyTemplateToOpenedFiles
          ];
```

These concrete subclasses of `MSSettingItem` provide easy way to store most common C and Objectice C objects to JSON:
* Boolean — saves `BOOL` variable
* Color — saves `NSColor` objects
* Double — saves `CGFloat` variables
* Enum — saves enumerations (unsigned char variables) with low and high limits
* Hotkey — saves hotkey: key code, mask and string characters to display
* Int — saves `NSInteger` variables
* Rect — saves `NSRect` structs
* Secure — saves password (secret key) in secured Keychain, and username — in plain settings file. Requires EMKeychain
* String Enum — saves `NSString` objects from finite number of options
* String — saves any `NSString` objects
