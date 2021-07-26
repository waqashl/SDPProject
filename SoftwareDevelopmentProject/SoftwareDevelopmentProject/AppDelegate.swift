//
//  AppDelegate.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 6/29/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true

        
        return true
    }

    

}
