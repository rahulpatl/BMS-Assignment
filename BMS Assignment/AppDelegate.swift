//
//  AppDelegate.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 07/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        applyNavigationTheme()
        setInitialViewController()
        return true
    }
    
    private func setInitialViewController() {
        let initialViewController = DashboardVC()
        let navigationController = UINavigationController(rootViewController: initialViewController)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    private func applyNavigationTheme() {
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().tintColor = .blue
    }
}

