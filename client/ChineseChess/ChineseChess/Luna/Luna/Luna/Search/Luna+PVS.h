//
//  Luna+PVS.h
//  Luna
//
//  Created by cheryl on 2022/6/17.
//
//

#import "Luna+Generate.h"

#import "Luna+Hash.h"
#import "Luna+Killer.h"
#import "Luna+Heuristic.h"

#import "Luna+PositionDetect.h"
#import "Luna+MoveExist.h"

typedef struct {
    LCMutablePositionRef position;
    LCMutableEvaluateRef evaluate;
    
    LCMutableHashHeuristicRef hashTable;
    LCMutableKillerMovesRef killersLayers;
    LCMutableHistoryTrackRef historyTable;
    
    LCMutableMovesArrayRef movesLayers;
    LCMutableHashHeuristicIORef io;
    
    LCMutablePositionHashRef hash;
    LCMutableMoveExistDetailRef detail;

    const Bool *isThinking;
    LCDepth rootDepth;
} LCNextStep;

typedef const LCNextStep *const LCNextStepRef;
typedef LCNextStep *const LCMutableNextStepRef;

// MARK: - LCNextStep Life Cycle
extern void LCNextStepAlloc(LCMutableNextStepRef nextStep);

extern void LCNextStepInit(LCMutableNextStepRef nextStep, Bool *isThinking, LCDepth rootDepth);

extern void LCNextStepDealloc(LCNextStepRef nextStep);

// MARK: - Search
extern void LCNextStepSearch(LCNextStepRef nextStep, void (^ block)(float, UInt16));
