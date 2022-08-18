//
//  NSString+Subscript.m
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "NSString+Subscript.h"

@implementation NSString (Subscript)

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)idx {
	return @([self characterAtIndex:idx]);
}

@end

@implementation NSString (Empty)

- (BOOL)isEmpty {
	return self.length == 0;
}

@end

@implementation NSMutableString (Unichar)

- (void)appendChar:(unichar)c {
	[self appendFormat:@"%C", c];
}

@end
