//
//  shootersNode.h
//  Defend&Shoot
//
//  Created by Yazan Khayyat on 2015-09-14.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ShootersNode : SKSpriteNode

+(instancetype)gameShooterAtPosition:(CGPoint)position;

+(instancetype)playerShooterAtPosition:(CGPoint)position;

@property (nonatomic, assign)int life;


@end
