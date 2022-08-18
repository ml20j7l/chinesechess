//
//  LunaRecord.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import <Foundation/Foundation.h>

@interface LunaRecord : NSObject
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *character;

@property (nonatomic) uint8_t chess;
@property (nonatomic) uint16_t move;
@property (nonatomic) uint8_t eat;

// rule
@property (nonatomic) NSString *position;
@property (nonatomic) uint8_t catch;

// String: Code Move
+ (LunaRecord *)recordWithString:(NSString *)string;

- (NSString *)textWithCode:(BOOL)withCode;

- (void)setCharacter:(NSString *)character count:(NSUInteger)count;

@end
