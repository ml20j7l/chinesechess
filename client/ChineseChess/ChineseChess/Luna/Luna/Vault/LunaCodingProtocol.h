//
//  LunaCodingProtocol.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import <Foundation/Foundation.h>

@protocol LunaCoding

@required
- (NSString *)encode:(const uint8_t *const)board;

- (void)decode:(NSString *)code board:(uint8_t *const)board;

- (NSString *)initialCode;

@end

