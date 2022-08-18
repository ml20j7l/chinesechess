//
//  Luna+MoveExist.m
//  Luna
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "Luna+MoveExist.h"

#include <stdlib.h>
#include <memory.h>

LCMutableMoveExistDetailRef LCMoveExistDetailCreateMutable(void) {
    const UInt64 size = sizeof(LCMoveExistDetail) * LCBoardMapLength;
    
    void *memory = malloc(size);
    memset(memory, 0, size);
    
    return memory == NULL ? NULL : (LCMoveExistDetail *)memory;
}

void LCMoveExistDetailClear(LCMutableMoveExistDetailRef detail) {
    const UInt64 size = sizeof(LCMoveExistDetail) * LCBoardMapLength;
    
    memset(detail, 0, size);
}

void LCMoveExistDetailRelease(LCMoveExistDetailRef detail) {
    if (detail == NULL) {
        return;
    }
    
    free((void *)detail);
}

const UInt64 LCMoveExistDetailOne = 1;
