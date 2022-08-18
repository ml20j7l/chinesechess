//
//  Luna+PositionLegal.m
//  Luna
//
//  Created by cheryl on 2022/6/25.
//  
//

#import "Luna+PositionLegal.h"

Bool _LCEatRLegalBlack[LCChessLength] = {
    0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
    
    1, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0,
    0, 0, 0, 0, 0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
};

Bool _LCEatRLegalRed[LCChessLength] = {
    0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    
    1, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0,
    0, 0, 0, 0, 0
};

Bool _LCEatCLegalBlack[LCChessLength] = {
    0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
};

Bool _LCEatCLegalRed[LCChessLength] = {
    0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 1,
    0, 0, 0, 0, 0
};

Bool _LCEatPLegalBlack[LCChessLength] = {
    0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
    
    0, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0,
    1, 1, 1, 1, 1,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
};

Bool _LCEatPLegalRed[LCChessLength] = {
    0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
    
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    
    0, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0,
    1, 1, 1, 1, 1
};

/* MARK:
 */
Bool LCPositionIsLegal(LCPositionRef position) {
#if LC_SingleThread
    static LCLocation king;
    static LCRowColumnOffsetRef offset;
#else
    LCLocation king;
    LCRowColumnOffsetRef offset;
#endif
    
    if (position->side) {
        king = position->chess[LCChessOffsetBlackK];
        
        offset = LCMoveArrayGetColumnOffset(position->column[LCLocationGetColumn(king)], LCLocationGetRow(king), LCMoveArrayConstRef->EatR);
        
       
        if (*(offset + 1)) {
            if (_LCEatRLegalBlack[position->board[king + (*(offset + 1) << 4)]]) {
                return false;
            }
            
            if (*(offset + 3) && _LCEatCLegalBlack[position->board[king + (*(offset + 3) << 4)]]) {
                return false;
            }
        }
        
        if (_LCEatPLegalBlack[position->board[king + 16]]) {
            return false;
        }
        
      
        if (*offset) {
            if (_LCEatRLegalBlack[position->board[king + (*offset << 4)]]) {
                return false;
            }
            
            if (*(offset + 2) && _LCEatCLegalBlack[position->board[king + (*(offset + 2) << 4)]]) {
                return false;
            }
        }
        
        offset = LCMoveArrayGetRowOffset(position->row[LCLocationGetRow(king)], LCLocationGetColumn(king), LCMoveArrayConstRef->EatR);
        
  
        if (*offset) {
            if (_LCEatRLegalBlack[position->board[king + *offset]]) {
                return false;
            }
            
            if (*(offset + 2) && _LCEatCLegalBlack[position->board[king + *(offset + 2)]]) {
                return false;
            }
        }
        
        if (_LCEatPLegalBlack[position->board[king - 1]]) {
            return false;
        }
        
      
        if (*(offset + 1)) {
            if (_LCEatRLegalBlack[position->board[king + *(offset + 1)]]) {
                return false;
            }
            
            if (*(offset + 3) && _LCEatCLegalBlack[position->board[king + *(offset + 3)]]) {
                return false;
            }
        }
        
        if (_LCEatPLegalBlack[position->board[king + 1]]) {
            return false;
        }
        
        // 馬
        register LCLocation leg = LCMoveMapConstRef->N[LCMoveMake(position->chess[LCChessOffsetRedN], king)];
        
        if (leg && !position->board[leg]) {
            return false;
        }
        
        leg = LCMoveMapConstRef->N[LCMoveMake(position->chess[LCChessOffsetRedN + 1], king)];
        
        if (leg && !position->board[leg]) {
            return false;
        }
        
        return true;
    } else {
        king = position->chess[LCChessOffsetRedK];
        
        offset = LCMoveArrayGetColumnOffset(position->column[LCLocationGetColumn(king)], LCLocationGetRow(king), LCMoveArrayConstRef->EatR);
        
       
        if (*offset) {
            if (_LCEatRLegalRed[position->board[king + (*offset << 4)]]) {
                return false;
            }
            
            if (*(offset + 2) && _LCEatCLegalRed[position->board[king + (*(offset + 2) << 4)]]) {
                return false;
            }
        }
        
        if (_LCEatPLegalRed[position->board[king - 16]]) {
            return false;
        }
        
       
        if (*(offset + 1)) {
            if (_LCEatRLegalRed[position->board[king + (*(offset + 1) << 4)]]) {
                return false;
            }
            
            if (*(offset + 3) && _LCEatCLegalRed[position->board[king + (*(offset + 3) << 4)]]) {
                return false;
            }
        }

        offset = LCMoveArrayGetRowOffset(position->row[LCLocationGetRow(king)], LCLocationGetColumn(king), LCMoveArrayConstRef->EatR);
        
    
        if (*offset) {
            if (_LCEatRLegalRed[position->board[king + *offset]]) {
                return false;
            }
            
            if (*(offset + 2) && _LCEatCLegalRed[position->board[king + *(offset + 2)]]) {
                return false;
            }
        }
        
        if (_LCEatPLegalRed[position->board[king - 1]]) {
            return false;
        }
        
     
        if (*(offset + 1)) {
            if (_LCEatRLegalRed[position->board[king + *(offset + 1)]]) {
                return false;
            }
            
            if (*(offset + 3) && _LCEatCLegalRed[position->board[king + *(offset + 3)]]) {
                return false;
            }
        }
        
        if (_LCEatPLegalRed[position->board[king + 1]]) {
            return false;
        }
        
        // 馬
        register LCLocation leg = LCMoveMapConstRef->N[LCMoveMake(position->chess[LCChessOffsetBlackN], king)];
        
        if (leg && !position->board[leg]) {
            return false;
        }
        
        leg = LCMoveMapConstRef->N[LCMoveMake(position->chess[LCChessOffsetBlackN + 1], king)];
        
        if (leg && !position->board[leg]) {
            return false;
        }
        
        return true;
    }
}
