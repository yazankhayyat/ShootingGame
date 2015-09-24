
//
//  GroundNode.m
//  Defend&Shoot
//
//  Created by Yazan Khayyat on 2015-09-17.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import "GroundNode.h"

@implementation GroundNode

+(instancetype) groundWithSize: (CGSize)size{
    GroundNode *ground = [self spriteNodeWithColor:[UIColor blackColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2, size.height/2);
    [ground setUpPhysicsBody];
    
    return ground;
    
}


-(void)setUpPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
}




@end
