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
        motionManager?.setCoreMotionManager()
        backgroundColor = .backGround
        for _ in 0...40 {
            createCrane()
        }
    }
    
    private func createCrane() {
        guard let randomCrane = Assets.crans.randomElement()?.rawValue else { return }
        let crane = SKSpriteNode(imageNamed: randomCrane)
        crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
        crane.position = CGPoint(x: CGFloat.random(in: size.width * 0.1...size.width * 0.9), y: CGFloat.random(in: size.height * 0.1...size.width * 0.9))
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
