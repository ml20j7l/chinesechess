//
//  Luna+PositionDetect.m
//  Luna
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "Luna+PositionDetect.h"

#include <stdlib.h>
#include <memory.h>

const LCZobristHash LCPositionHashHighMask = 0x1ff00; // 0001 1111 1111 0000 0000.
const LCZobristKey LCPositionHashLowMask = 0xff; // 1111 1111.

LCMutablePositionHashRef LCPositionHashCreateMutable(void) {
    const UInt64 size = sizeof(LCPositionHash) * (1 << 18);
    
    void *memory = malloc(size);
    
    return memory == NULL ? NULL : (LCPositionHash *)memory;
}

void LCPositionHashClear(LCMutablePositionHashRef hash) {
    const UInt64 size = sizeof(LCPositionHash) * (1 << 18);
    
    memset(hash, 0, size);
}

void LCPositionHashRelease(LCPositionHashRef hash) {
    if (hash == NULL) {
        return;
    }
    
    free((void *)hash);
}
