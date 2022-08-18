//
//  LunaRecordRuler.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import <Foundation/Foundation.h>
#import "Luna.h"

@class LunaRecord;
@interface LunaRecordRuler : NSObject

+ (LunaBoardState)analyzeWithRecords:(NSArray<LunaRecord *> *)records currentSide:(const uint8_t)side chesses:(uint32_t)chesses;

@end
