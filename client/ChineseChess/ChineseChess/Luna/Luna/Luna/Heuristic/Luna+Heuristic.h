//
//  Luna+Heuristic.h
//  Luna
//
//  Created by cheryl on 2022/6/17.
//
//

#import "Luna+PreGenerate.h"

/* MARK: - LCHistoryTrack
 * the index is move.
 */
typedef UInt64 LCHistoryTrack;

typedef const LCHistoryTrack *const LCHistoryTrackRef;
typedef LCHistoryTrack *const LCMutableHistoryTrackRef;

// MARK: - LCHistoryTrack Life Cycle
extern LCMutableHistoryTrackRef LCHistoryTrackCreateMutable(void);

extern void LCHistoryTrackClear(LCMutableHistoryTrackRef history);

extern void LCHistoryTrackRelease(LCHistoryTrackRef history);

// MARK: - Write
LC_INLINE void LCHistoryTrackRecord(LCMutableHistoryTrackRef history, const LCMove move, const UInt8 depth) {
    history[move] += depth;
}
