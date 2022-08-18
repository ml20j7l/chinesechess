//
//  Luna+Const.h
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "Luna+Typedef.h"

// MARK: - Luna Init Data.
typedef struct {
	const LCLocation Chess[LCChessLength];
	const LCLocation Board[LCBoardLength];
} LCInitialData;

extern const LCInitialData LCInitialDataConst;

// MARK: - Luna Legal Location.
typedef struct {
	const Bool Board[LCBoardLength];
	const Bool K[LCBoardLength];
	const Bool A[LCBoardLength];
	const Bool B[LCBoardLength];
	const Bool P[LCBoardLength << 1];
	const LCLocation River;
} LCLegalLocation;

extern const LCLegalLocation LCLegalLocationConst;
