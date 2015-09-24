//
//  GameScene.m
//  Defend&Shoot
//
//  Created by Yazan Khayyat on 2015-09-14.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import "GameScene.h"

NS_ENUM(NSInteger, bulletState) {
    
    bulletStateFired = 0,
    bulletStateNotFired = 1
};

@interface GameScene ()


@property (nonatomic, assign) enum bulletState bulletState;
@property (nonatomic, strong) SKSpriteNode *lastBulletNode;
@property (nonatomic, strong) SKSpriteNode *lastEnemyBulletNode;
@property (nonatomic, assign) BOOL enemyJumping;
@property (nonatomic, assign) BOOL gameRunning;
@property (nonatomic, strong) SKLabelNode *playerShooterLife;
@property (nonatomic, strong) SKLabelNode *enemyShooterLife;
@property (nonatomic, strong) NSTimer *timer;


@end


@implementation GameScene


-(void)didMoveToView:(SKView *)view {
    self.playerShooter = [ShootersNode playerShooterAtPosition:CGPointMake(self.frame.size.width * 0.1, self.frame.size.height / 3.5)];
    self.playerShooter.zPosition = 1;
    self.playerShooter.size = CGSizeMake(90, 90);
    
    [self addChild:self.playerShooter];
    self.gameShooter = [ShootersNode gameShooterAtPosition:CGPointMake(self.frame.size.width * 0.9 , self.frame.size.height / 3.5)];
    self.gameShooter.size = CGSizeMake(90, 90);
    self.gameShooter.zPosition = 1;
    self.initialEnemyPosition = CGPointMake(self.frame.size.width * 0.9 , (self.frame.size.height / 3.5));
    [self addChild:self.gameShooter];
    
    self.ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, self.playerShooter.position.y - 55)];
    [self addChild:self.ground];
    self.bulletState = bulletStateNotFired;
    
    
    SKLabelNode *playerLife = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    playerLife.text = @"Life: ";
    playerLife.color = [UIColor whiteColor];
    playerLife.fontSize = 15;
    playerLife.zPosition = 2.0;
    playerLife.position = CGPointMake(self.frame.size.width * 0.1 , self.frame.size.height * 0.9);
    self.playerShooterLife = playerLife;
    [self addChild:self.playerShooterLife];
    
    SKLabelNode *enemyLife = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    enemyLife.text = @"Life: ";
    enemyLife.color = [UIColor whiteColor];
    enemyLife.fontSize = 15;
    enemyLife.zPosition = 2.0;
    enemyLife.position = CGPointMake(self.initialEnemyPosition.x, self.frame.size.height * 0.9);
    self.enemyShooterLife = enemyLife;
    [self addChild:self.enemyShooterLife];
    self.gameRunning = YES;
    [self tryToShoot];
    
    }


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *playerBulletNode = [SKSpriteNode spriteNodeWithImageNamed:@"bullet"];
        playerBulletNode.xScale = 0.5;
        playerBulletNode.yScale = 0.5;


        self.initialPlayerBulletPosition = CGPointMake(self.playerShooter.position.x + 65, self.playerShooter.position.y - 15);
        self.initialEnemyBulletPosition = CGPointMake(self.gameShooter.position.x - 65, self.gameShooter.position.y - 15);
        playerBulletNode.position = self.initialPlayerBulletPosition;
        //self.bulletState == bulletStateNotFired ||
        if ((location.x < self.frame.size.width / 2 && (!self.lastBulletNode || (self.lastBulletNode.position.x >= self.playerShooter.position.x + 350)))) {
            
            SKAction *action1 = [SKAction moveTo:CGPointMake(self.gameShooter.position.x + 50,
                                                        [@[@((self.initialEnemyPosition.y * 0.09) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.08) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.07) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.06) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.05) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.04) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.03) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.02) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.01) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.1) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.11) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.12) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.13) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.14) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.15) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y * 0.16) + self.initialEnemyPosition.y),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.09),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.08),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.07),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.06),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.05),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.04),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.03),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.02),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.01),
                                                            @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.1),
                                                           @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.11),
                                                           @((self.initialEnemyPosition.y) - self.initialEnemyPosition.y * 0.12),
                                                            @(self.initialEnemyPosition.y)][(arc4random() % 27)] floatValue]) duration:0.8];
            SKAction *action2 = [SKAction removeFromParent];
            NSArray *actionsArray = [[NSArray alloc]initWithObjects:action1, action2, nil];
            SKAction *sequence = [SKAction sequence:actionsArray];
            
            [playerBulletNode runAction:[SKAction repeatActionForever:sequence]];
            
            [self addChild:playerBulletNode];
            [self enemyDodge];
            self.bulletState = bulletStateFired;
            self.lastBulletNode = playerBulletNode;

        }
        
        else if ((location.x > self.frame.size.width / 2 && self.playerShooter.position.y == self.initialPlayerPosition.y)) {
            SKAction *action1 = [SKAction moveToY:self.ground.position.y duration:0.3];
            SKAction *action2 = [SKAction moveToY:self.initialPlayerPosition.y duration:0.3];
            NSArray *actionsArray = [[NSArray alloc]initWithObjects:action1, action2, nil];
            SKAction *sequence = [SKAction sequence:actionsArray];
            [self.playerShooter runAction:sequence];
//            [self tryToShoot];
        }
       
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (self.lastBulletNode != nil) {
        
        SKSpriteNode *playerBulletNode = self.lastBulletNode;
        
//        NSLog(@"bullet y = %f, y bounds = (%f, %f)", playerBulletNode.position.y,((self.initialEnemyPosition.y * 0.16) + self.initialEnemyPosition.y), ((self.initialEnemyPosition.y * 0.1) + self.initialEnemyPosition.y) );
        
        CGFloat enemyTopBoundary = self.gameShooter.position.y + (self.gameShooter.size.height/2);
        CGFloat enemyMidBoundary = self.gameShooter.position.y;
        CGFloat enemyBottomBoundary = self.gameShooter.position.y - (self.gameShooter.size.height/2);
        CGFloat enemyLeftBoundary = self.gameShooter.position.x - (self.gameShooter.size.width/2);
        CGFloat enemyRightBoundary = self.gameShooter.position.x;
        

        
        if ( (playerBulletNode.position.y <= enemyTopBoundary && playerBulletNode.position.y > enemyMidBoundary) && (playerBulletNode.position.x >= enemyLeftBoundary && playerBulletNode.position.x <= enemyRightBoundary))
        {
            NSLog(@"hit");
            self.gameShooter.life -= 1;
            self.enemyShooterLife.text = [NSString stringWithFormat:@"Life: %d", self.gameShooter.life];
            self.lastEnemyBulletNode = nil;
            if (self.gameShooter.life < 0.5) {
                self.gameRunning = NO;
                SKLabelNode *gameWin = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
                gameWin.text = @"You win!";
                gameWin.color = [UIColor redColor];
                gameWin.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                gameWin.zPosition = 1;
                [self addChild:gameWin];
                
                
            }
            
        else if ( (playerBulletNode.position.y <= enemyMidBoundary && playerBulletNode.position.y >= enemyBottomBoundary) && (playerBulletNode.position.x >= enemyLeftBoundary && playerBulletNode.position.x <= enemyRightBoundary)) {
                
                self.gameShooter.life -= 0.5;
                self.enemyShooterLife.text = [NSString stringWithFormat:@"Life: %d", self.gameShooter.life];
                self.lastEnemyBulletNode = nil;
            
            }

        }
    }
    
    
}

-(void)enemyDodge {
     NSLog(@"initialenemy: %f, gameshooter: %f, bullet: %f, gameshooter x: %f", self.initialEnemyPosition.y, self.gameShooter.position.y, self.lastBulletNode.position.y, self.gameShooter.position.x);
    
    if(!self.enemyJumping)
    {
        self.enemyJumping = YES;
        SKAction *action1 = [SKAction moveToY:self.ground.position.y duration:0.3];
        SKAction *action2 = [SKAction moveToY:self.initialEnemyPosition.y duration:0.3];
        NSArray *actionsArray = [[NSArray alloc]initWithObjects:action1, action2, nil];
        SKAction *sequence = [SKAction sequence:actionsArray];
        [self.gameShooter runAction:sequence completion:^{
            self.enemyJumping = NO;
            [self createShootTimer];
        }];
    }

}

-(void)enemyShoot {
    if (!((self.gameShooter.position.y >= self.initialEnemyPosition.y * 0.95) && (self.gameShooter.position.y <= (self.initialEnemyPosition.y * 1.05) + self.initialEnemyPosition.y))) {
        return;
    }
    CGFloat playerTopBoundary = self.playerShooter.position.y + (self.playerShooter.size.height/2);
    CGFloat playerMidBoundary = self.playerShooter.position.y;
//    CGFloat playerBottomBoundary = self.playerShooter.position.y - (self.playerShooter.size.height/2);
    CGFloat playerLeftBoundary = self.playerShooter.position.x - (self.playerShooter.size.width/2);
    CGFloat playerRightBoundary = self.playerShooter.position.x;
    
    self.initialEnemyBulletPosition = CGPointMake(self.gameShooter.position.x - 65, self.gameShooter.position.y - 15);
    SKSpriteNode *gameBulletNode = [SKSpriteNode spriteNodeWithImageNamed:@"bullet"];
    gameBulletNode.xScale = 0.5;
    gameBulletNode.yScale = 0.5;
    gameBulletNode.position = self.initialEnemyBulletPosition;
    SKAction *action1 = [SKAction moveTo:CGPointMake(self.initialPlayerPosition.x + 40,
                                                     [@[@((self.initialPlayerPosition.y * 0.09) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.08) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.07) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.06) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.05) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.04) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.03) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.02) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.01) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.1) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.11) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.12) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.13) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.14) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.15) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y * 0.16) + self.initialPlayerPosition.y),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.09),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.08),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.07),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.06),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.05),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.04),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.03),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.02),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.01),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.1),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.11),
                                                        @((self.initialPlayerPosition.y) - self.initialPlayerPosition.y * 0.12),
                                                        @(self.initialEnemyPosition.y)][(arc4random() % 27)] floatValue]) duration:0.8];
    SKAction *action2 = [SKAction removeFromParent];
    NSArray *actionsArray = [[NSArray alloc]initWithObjects:action1, action2, nil];
    SKAction *sequence = [SKAction sequence:actionsArray];
    [self addChild:gameBulletNode];
    
    [gameBulletNode runAction:sequence completion:^{
        [self tryToShoot];
       
    }];
    
    gameBulletNode = self.lastEnemyBulletNode;
    
    if ( (gameBulletNode.position.y <= playerTopBoundary && gameBulletNode.position.y > playerMidBoundary) && (gameBulletNode.position.x >= playerLeftBoundary && gameBulletNode.position.x <= playerRightBoundary))
    {
        NSLog(@"hit");
        self.playerShooter.life -= 1;
        self.playerShooterLife.text = [NSString stringWithFormat:@"Life: %d", self.playerShooter.life];
        self.lastBulletNode = nil;
        if (self.playerShooter.life < 0.5) {
            SKLabelNode *gameLose = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            gameLose.text = @"You Lose!";
            gameLose.color = [UIColor redColor];
            gameLose.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            gameLose.zPosition = 1;
            [self addChild:gameLose];
            
        }
    }
    
}

- (void)createShootTimer
{
    if (self.timer == nil) {
        self.timer = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(tryToShoot) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)tryToShoot {
    
    if (self.lastEnemyBulletNode.position.x <= self.playerShooter.position.x + 45) {
        [self enemyShoot];
        [self.timer invalidate];
        self.timer = nil;
    }
    else if (self.timer == nil) {
        [self createShootTimer];
    }
}


@end
