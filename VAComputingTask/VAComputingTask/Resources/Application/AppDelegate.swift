//
//  AppDelegate.swift
//  VAComputingTask
//
//  Created by gody on 9/19/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator:AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window ?? UIWindow())
        coordinator?.start()
        return true
    }
    
}

