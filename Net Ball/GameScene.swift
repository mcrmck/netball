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
    var touchPosition = CGPoint()
    var angle = CGFloat()
    
    override func didMove(to view: SKView) {
        player1 = self.childNode(withName: "player1") as? SKSpriteNode
        net = self.childNode(withName: "net") as? SKSpriteNode
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
           
            
            // Get sprite's current position (a.k.a. starting point).
            let currentPosition = player1!.position
            print("current X:" ,currentPosition.x)
            print("current Y:" ,currentPosition.y)

            // Get touch position
            touchPosition = t.location(in: self)
            print("touch X:", touchPosition.x)
            print("touch Y:", touchPosition.y)
            
            // Calculate the angle using the relative positions of the sprite and touch.
            angle = atan2(touchPosition.y, touchPosition.x)
            print("angle:", angle)

            // Define actions for the ship to take.
            let rotateAction = SKAction.rotate(toAngle: angle + .pi/2, duration: 0.0)
            let moveAction = SKAction.move(to: touchPosition, duration: 0.0)

            // Tell the ship to execute actions.
            player1!.run(SKAction.sequence([rotateAction, moveAction]))
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
    }
}
