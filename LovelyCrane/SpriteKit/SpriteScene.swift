//
//  SKScean.swift
//  LoveCrane
//
//  Created by 최진용 on 2023/07/15.
//


import CoreMotion
import SceneKit
import SpriteKit
import SwiftUI


final class SpriteScene: SKScene {

    var motionManager: MotionManager?
    

    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        backgroundColor = .red
        motionManager?.setCoreMotionManager()
        createCrane()
    }
    
    private func createCrane() {
        let crane = SKSpriteNode(imageNamed: "favorite")
        crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
        crane.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: size.height * 0.9)
        addChild(crane)
    }
    
    //해당 메소드는 없어도 됩니다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createCrane()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerDate = motionManager?.coreMotionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerDate.acceleration.x * 9.8, dy: accelerometerDate.acceleration.y * 9.8)
        }
    }
    
}
