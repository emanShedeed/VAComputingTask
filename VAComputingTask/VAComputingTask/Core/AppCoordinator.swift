//
//  AppCoordinator.swift
//  VAComputingTask
//
//  Created by gody on 9/19/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var window:UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
    }
    
    func start() {
       let vc = ComputingViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
    }
}
