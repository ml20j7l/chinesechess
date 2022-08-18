//
//  Luna+PositionDetect.h
//  Luna
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "Luna+Evaluate.h"

// MARK: - Position Draw
LC_INLINE Bool LCPositionIsDraw(LCPositionRef position) {
    return !(position->bitchess & 0xffe0ffe0);
}

// MARK: - Position Death
LC_INLINE Bool LCPositionWasMate(const Int16 alpha, const Int8 distance) {
    return alpha >= (LCPositionCheckMateValue - distance);
}

// MARK: - Position Repetition
typedef LCZobristKey LCPositionHash;

typedef const LCPositionHash *const LCPositionHashRef;
typedef LCPositionHash *const LCMutablePositionHashRef;

// MARK: - LCPositionHash Life Cycle
extern LCMutablePositionHashRef LCPositionHashCreateMutable(void);

extern void LCPositionHashClear(LCMutablePositionHashRef hash);

extern void LCPositionHashRelease(LCPositionHashRef hash);

// MARK: - Write & Read
extern const LCZobristHash LCPositionHashHighMask;
extern const LCZobristKey LCPositionHashLowMask;

#define LCPositionGetHashKey(position) (((position->hash & LCPositionHashHighMask) | (position->key & LCPositionHashLowMask)) + position->side)
#define LCPositionGetHashValue(position) (position->key)

LC_INLINE void LCPositionHashSetPosition(LCMutablePositionHashRef hash, LCPositionRef position) {
    *(hash + LCPositionGetHashKey(position)) = LCPositionGetHashValue(position);
}

LC_INLINE void LCPositionHashRemovePosition(LCMutablePositionHashRef hash, LCPositionRef position) {
    *(hash + LCPositionGetHashKey(position)) = 0;
}

LC_INLINE Bool LCPositionHashContainsPosition(LCPositionHashRef hash, LCPositionRef position) {
    return *(hash + LCPositionGetHashKey(position)) == LCPositionGetHashValue(position);
}
