//
//  Paddle.m
//
//  Created by : Lars Birkemose
//  Project    : pong-objc
//  Date       : 20/08/15
//
//  Copyright (c) 2015 Cocos2D.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Paddle.h"

// -----------------------------------------------------------------

@implementation Paddle
{
    CGSize _gameSize;
}

// -----------------------------------------------------------------

+ (instancetype)paddleWithSide:(PaddleSide)side
{
    return [[self alloc] initWithSide:side];
}

- (instancetype)initWithSide:(PaddleSide)side
{
    // always always always assert input parameters if possible
    NSAssert(side < PaddleSideInvalid, @"You’ve never heard of the Millennium Falcon?");
    
    self = [super initWithImageNamed:@"paddle.png"];
    
    _gameSize = [CCDirector sharedDirector].viewSize;
    _side = side;
    float x = (side == PaddleSideLeft) ? kGamePaddleInset : _gameSize.width - kGamePaddleInset;
    _destination = _gameSize.height * 0.5;
    self.position = (CGPoint){x, _destination};
    
    // yeah, it is default set to nil, but I like to preset all iVars
    _touch = nil;
            
    return self;
}

// -----------------------------------------------------------------

- (BOOL)validPosition:(CGPoint)position
{
    if (_side == PaddleSideLeft) return (position.x < kGamePaddleTouchArea);
    return (position.x > (_gameSize.width - kGamePaddleTouchArea));
}

// -----------------------------------------------------------------

- (void)setDestination:(float)destination
{
    // clamp destination to avoid paddle moving outside the board
    float halfHeight = self.contentSize.height * 0.5;
    _destination = clampf(destination, halfHeight, _gameSize.height - halfHeight);
}

// -----------------------------------------------------------------

- (void)update:(CCTime)delta
{
    // move to destination at light speed
    // calculate remaining distance and step
    float remainingDistance = fabs(self.position.y - _destination);
    float step = kGamePaddleSpeed * delta;

    if (step > remainingDistance)
    {
        // if close enough, complete move to destination
        self.position = (CGPoint){self.position.x, _destination};
    }
    else
    {
        // else step towards desination
        if (_destination > self.position.y)
        {
            self.position = (CGPoint){self.position.x, self.position.y + step};
        }
        else
        {
            self.position = (CGPoint){self.position.x, self.position.y - step};
        }
    }
}

// -----------------------------------------------------------------

@end





