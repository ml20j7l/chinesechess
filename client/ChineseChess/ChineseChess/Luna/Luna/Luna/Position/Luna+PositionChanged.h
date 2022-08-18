//
//  Luna+PositionChanged.h
//  Luna
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "Luna+Evaluate.h"
#import "Luna+Generate.h"

extern void LCPositionChanged(LCMutablePositionRef position, LCMutableEvaluateRef evaluate, LCMoveRef move, UInt16 *const buffer);

extern void LCPositionRecover(LCMutablePositionRef position, LCMutableEvaluateRef evaluate, LCMoveRef move, UInt16 *const buffer);

extern Bool LCPositionIsLegalIfChangedByMove(LCMutablePositionRef position, LCMoveRef move, UInt16 *const buffer);
