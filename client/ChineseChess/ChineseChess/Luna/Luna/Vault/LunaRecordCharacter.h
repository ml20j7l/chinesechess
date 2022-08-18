//
//  LunaRecordCharacter.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import <Foundation/Foundation.h>

@interface LunaRecordCharacter : NSObject

+ (NSString *)characterRecordWithMove:(const uint16_t)move board:(const uint8_t *const)board array:(const uint8_t *const)array;

@end
