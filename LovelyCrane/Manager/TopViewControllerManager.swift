//
//  TopViewControllerManager.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import UIKit

// MARK: 최상단 뷰컨트롤러
final class TopViewControllerManager {
    static let shared = TopViewControllerManager()
    private init() { }
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        
        return topViewController(for: window?.rootViewController)
    }
    
    private func topViewController(for controller: UIViewController?) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(for: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(for: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(for: presented)
        }
        
        return controller
    }
}
