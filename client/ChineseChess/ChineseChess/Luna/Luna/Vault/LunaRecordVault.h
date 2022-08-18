//
//  LunaRecordVault.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import <Foundation/Foundation.h>

@interface LunaRecordVault : NSObject

+ (UInt16)searchVaultWithFEN:(NSString *)FEN targetSide:(BOOL)side;

#if DEBUG
+ (void)expandVaultWithDirectory:(NSString *)directory;

+ (void)writeToFile:(NSString *)path;
#endif

@end
