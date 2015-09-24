//
//  shootersNode.m
//  Defend&Shoot
//
//  Created by Yazan Khayyat on 2015-09-14.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import "ShootersNode.h"

@implementation ShootersNode

+(instancetype)gameShooterWithSprite:(NSString *)spriteName {
    ShootersNode *gameShooter = [ShootersNode spriteNodeWithImageNamed:spriteName];
    gameShooter.name = spriteName;
    gameShooter.life = 10;
    return gameShooter;
}

+(instancetype)gameShooterAtPosition:(CGPoint)position{
    
    ShootersNode *gameShooter = [ShootersNode gameShooterWithSprite:@"GameShooter"];
    gameShooter.position = position;
    return gameShooter;
    
 
}

+(instancetype)playerShooterAtPosition:(CGPoint)position{

    ShootersNode *playerShooter = [ShootersNode gameShooterWithSprite:@"PlayerShooter"];
    playerShooter.position = position;
    return playerShooter;
    
}
@end
