//
//  Luna+Evaluate.h
//  Luna
//
//  Created by cheryl on 2022/6/19.
//
//

#import "Luna+Position.h"

typedef struct {
	const Int16 * dynamicChessValue[LCChessLength];
	Int16 material;
	Int16 value;
} LCEvaluate;

typedef const LCEvaluate *const LCEvaluateRef;
typedef LCEvaluate *const LCMutableEvaluateRef;

// MARK: - LCEvaluate Life Cycle
extern LCMutableEvaluateRef LCEvaluateCreateMutable(void);

extern void LCEvaluateInit(LCMutableEvaluateRef evaluate, LCPositionRef position);

extern void LCEvaluateRelease(LCEvaluateRef evaluate);

// MARK: - Evaluate
extern Int16 LCEvaluatePosition(LCMutableEvaluateRef evaluate, LCPositionRef position);

// MARK: - Const Value
extern const Int16 LCPositionDrawValue;
extern const Int16 LCPositionCheckMateValue;
extern const Int16 LCPositionWinValue;
