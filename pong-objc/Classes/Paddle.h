//
//  Paddle.h
//
//  Created by : Lars Birkemose
//  Project    : pong-objc
//  Date       : 20/08/15
//
//  Copyright (c) 2015 Cocos2D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameTypes.h"

// -----------------------------------------------------------------

typedef NS_ENUM(NSUInteger, PaddleSide)
{
    PaddleSideLeft,
    PaddleSideRight,
    PaddleSideInvalid
};

// -----------------------------------------------------------------

@interface Paddle : CCSprite

// -----------------------------------------------------------------

@property (nonatomic, readonly) PaddleSide side;
// we are not allowed to retain touches, iOS does that for us, so keep any reference weak
@property (nonatomic, weak) UITouch *touch;
@property (nonatomic, assign) float destination;

// -----------------------------------------------------------------

+ (instancetype)paddleWithSide:(PaddleSide)side;

- (BOOL)validPosition:(CGPoint)position;

// -----------------------------------------------------------------

@end




