//
//  MotionManager.swift
//  LoveCrane
//
//  Created by 최진용 on 2023/07/15.
//

import CoreMotion
import SwiftUI


protocol SetCoreMotionManager {
    var coreMotionManager: CMMotionManager {get set}
    func setCoreMotionManager()
}

class MotionManager: SetCoreMotionManager {
    private init() { }
    static let shared = MotionManager()
    var coreMotionManager: CMMotionManager = CMMotionManager()
    
    func setCoreMotionManager() {
        coreMotionManager.accelerometerUpdateInterval = 0.2
        coreMotionManager.deviceMotionUpdateInterval = 0.2
        coreMotionManager.gyroUpdateInterval = 0.2
        
        coreMotionManager.startGyroUpdates()
        coreMotionManager.startAccelerometerUpdates()
    }
    
    
    
}
