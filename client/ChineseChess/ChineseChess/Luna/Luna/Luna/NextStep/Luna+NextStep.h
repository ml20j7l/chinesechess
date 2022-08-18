//
//  Luna+NextStep.h
//  Luna
//
//  Created by cheryl on 2022/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LunaNextStep : NSObject

- (void)nextStepWithFEN:(NSString *)FEN
             targetSide:(BOOL)side
            searchDepth:(int)depth
            bannedMoves:(NSArray<NSNumber *> *)bannedMoves
             isThinking:(BOOL *)isThinking
                  block:(void (^)(float progress, UInt16 move))block;

@end

NS_ASSUME_NONNULL_END
