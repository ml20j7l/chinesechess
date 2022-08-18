//
//  NSString+Subscript.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import <Foundation/Foundation.h>

@interface NSString (Subscript)

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)idx;

@end

@interface NSString (Empty)

- (BOOL)isEmpty;

@end

@interface NSMutableString (Unichar)

- (void)appendChar:(unichar)c;

@end
