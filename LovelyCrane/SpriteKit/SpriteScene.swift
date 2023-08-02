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
    private var letterCount: Int
    
    var craneCount = 0
    var nodes: [SKNode] = []
    
    init(size: CGSize, letterCount: Int) {
        self.letterCount = letterCount
        super.init(size: size)
        if letterCount > 100 {
            self.craneCount = 100
        }
        else {
            self.craneCount = letterCount
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        motionManager?.setCoreMotionManager()
        backgroundColor = .backGround
        NotificationCenter.default.addObserver(self, selector: #selector(addNewCrane), name: NSNotification.Name("write"), object: nil)
        for _ in 0..<craneCount {
            createCrane()
        }
    }
    
    @objc func addNewCrane(_ notification: NSNotification) {
        if craneCount <= 100 {
            let newCrane = notification.object as! String
            let crane = SKSpriteNode(imageNamed: newCrane)
            crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
            crane.position = CGPoint(x: CGFloat.random(in: size.width * 0.1...size.width * 0.9), y: size.width * 1)
            craneCount += 1
            nodes.append(crane)
            addChild(crane)
        }
        if craneCount > 100 {
            nodes.popLast()?.removeFromParent()
            print(nodes.count)
            let newCrane = notification.object as! String
            let crane = SKSpriteNode(imageNamed: newCrane)
            crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
            crane.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
            nodes.append(crane)
            addChild(crane)
        }
    }
    
    
    private func createCrane() {
        guard let randomCrane = Assets.crans.randomElement()?.rawValue else { return }
        let crane = SKSpriteNode(imageNamed: randomCrane)
        crane.physicsBody = SKPhysicsBody(texture: crane.texture!, size: crane.texture!.size())
        crane.position = CGPoint(x: CGFloat.random(in: size.width * 0.1...size.width * 0.9), y: CGFloat.random(in: size.height * 0.1...size.height * 0.9))
        nodes.append(crane)
        addChild(crane)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerDate = motionManager?.coreMotionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerDate.acceleration.x * 9.8, dy: accelerometerDate.acceleration.y * 9.8)
        }
    }
    
}
