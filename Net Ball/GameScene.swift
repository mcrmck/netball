//
//  GameScene.swift
//  Net Ball
//
//  Created by Patrick McCormack on 10/27/19.
//  Copyright © 2019 Hop Codes. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player1: SKSpriteNode?
    var net: SKSpriteNode?
    var ball: SKSpriteNode?
    var touchPosition = CGPoint()
    var angle = CGFloat()
    var p1desPos = CGPoint()
    var distance = CGFloat()
    var mag = CGFloat()

    
    
    override func didMove(to view: SKView) {
        player1 = self.childNode(withName: "player1") as? SKSpriteNode
        net = self.childNode(withName: "net") as? SKSpriteNode
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        
        ball?.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 20))
        
        //adding a border for testing purposes
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        angle = .pi/2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self))
            touchPosition = t.location(in: self)
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))

            // Get touch position
            touchPosition = t.location(in: self)
            print("touch X:", touchPosition.x)
            print("touch Y:", touchPosition.y)
            
            distance = sqrt((touchPosition.x * touchPosition.x) + (touchPosition.y * touchPosition.y))
            print("distance: ", distance)
            
            
            // Calculate the angle using the relative positions of the sprite and touch.
            angle = atan2(touchPosition.y, touchPosition.x)
            print("angle:", angle)
            
            // Calculate desired position using angle
       
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        net?.zRotation = angle - .pi/2
        
        if (distance > 200) {
            distance = 200
        }
        mag = 225 + distance
        p1desPos.x = mag * cos(angle)
        p1desPos.y = mag * sin(angle)
        player1?.position = p1desPos
        player1?.zRotation = angle + .pi/2
    }
}
