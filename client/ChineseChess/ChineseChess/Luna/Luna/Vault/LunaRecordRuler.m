//
//  LunaRecordRuler.m
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "LunaRecordRuler.h"
#import "LunaRecord.h"

@implementation LunaRecordRuler

+ (LunaBoardState)analyzeWithRecords:(NSArray<LunaRecord *> *)records currentSide:(const uint8_t)side chesses:(uint32_t)chesses {
    if (records.count == 0) {
        return side;
    }
	
	
	const uint8_t steps = 9;
	if (records.lastObject.catch && records.count >= steps) {
		NSArray<LunaRecord *> *rounds = [records subarrayWithRange:NSMakeRange(records.count - steps, steps)];
		BOOL isLongCatch = YES;
		
		for (int index = 0, max = steps - 1; index < max; index += 2) {
			LunaRecord *last = rounds.lastObject;
			LunaRecord *step = rounds[index];
			
			if (last.chess == step.chess && last.catch == step.catch) {
				continue;
			} else {
				isLongCatch = NO;
				break;
			}
		}
		
		if (isLongCatch) {
			return side ? LunaBoardStateWinLongCatchBlack : LunaBoardStateWinLongCatchRed;
		}
	}
	
	
	if (!(chesses & 0xffe0ffe0)) {
		return LunaBoardStateDrawBothSideHaveNoneAttckChess;
	}
	
	
	if (records.count > 10) {
		NSMutableArray<NSString *> *positions = [NSMutableArray arrayWithCapacity:records.count];
		
		for (LunaRecord *record in records) {
			[positions addObject:record.position];
		}
		
		for (int index = (int)(positions.count - 1); index >= 10; index --) {
			NSInteger count = 0;
			
			for (NSString *position in positions) {
				if ([positions[index] isEqualToString:position]) {
					count++;
				}
			}
			
			if (count > 5) {
				return LunaBoardStateDrawSamePositionMultiTimes;
			}
		}
	}
	
	
	if (records.count > 100) {
		uint8_t count = 0;
		
		for (int index = (int)(records.count - 1); index >= 0; index--, count++) {
			if (records[index].eat) {
				break;
			}
		}
		
		if (count > 100) {
			return LunaBoardStateDraw50RoundHaveNoneEat;
		}
	}
	
	return side;
}

@end
