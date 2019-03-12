//
//  AppDelegate.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureAppearance()
        return true
    }

    private func configureAppearance() {
        
        UIApplication.statusBarBackgroundColor = UIColor.statusBar
        
        UINavigationBar.appearance().backgroundColor = UIColor.navigationBar
        UINavigationBar.appearance().barStyle = .blackTranslucent
        UINavigationBar.appearance().barTintColor = UIColor.navigationBar
        UINavigationBar.appearance().tintColor = UIColor.navigationBarTint
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.navigation
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.navigation], for: .normal)
    }
}

