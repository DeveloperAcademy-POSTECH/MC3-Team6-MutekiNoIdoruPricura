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
        NotificationCenter.default.addObserver(self, selector: #selector(addNewCrane), name: NSNotification.Name("write"), object: nil)
        for _ in 0...40 {
            createCrane()
        }
    }
    
    @objc func addNewCrane(_ notification: NSNotification) {
        let newCrane = notification.object as! String
        let crane = SKSpriteNode(imageNamed: newCrane)
//        crane.scale(to: CGSize(width: UIScreen.getWidth(21), height: UIScreen.getHeight(19)))
        crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
        crane.position = CGPoint(x: CGFloat.random(in: size.width * 0.1...size.width * 0.9), y: size.width * 1)
        addChild(crane)
    }
    
    
    private func createCrane() {
        guard let randomCrane = Assets.crans.randomElement()?.rawValue else { return }
        let crane = SKSpriteNode(imageNamed: randomCrane)
//        crane.scale(to: CGSize(width: UIScreen.getWidth(21), height: UIScreen.getHeight(19)))
        crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
        crane.position = CGPoint(x: CGFloat.random(in: size.width * 0.1...size.width * 0.9), y: CGFloat.random(in: size.height * 0.1...size.height * 0.9))
        addChild(crane)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerDate = motionManager?.coreMotionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerDate.acceleration.x * 9.8, dy: accelerometerDate.acceleration.y * 9.8)
        }
    }
    
}
