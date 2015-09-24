//
//  GameScene.h
//  Defend&Shoot
//

//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ShootersNode.h"
#import "GroundNode.h"

@interface GameScene : SKScene
@property (nonatomic, strong)ShootersNode *playerShooter;
@property (nonatomic, strong)ShootersNode *gameShooter;
@property (nonatomic, strong) SKSpriteNode* spirteNode;
@property CGPoint initialPlayerBulletPosition;
@property CGPoint initialEnemyBulletPosition;
@property CGPoint initialPlayerPosition;
@property CGPoint initialEnemyPosition;
@property (nonatomic, strong)SKAction *action;
@property (nonatomic, strong) SKSpriteNode* bullet;
@property (nonatomic, strong) GroundNode *ground;

@end
