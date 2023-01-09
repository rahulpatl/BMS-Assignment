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
        tabBarAppearance()
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationBarAppearance.backgroundColor = UIColor.systemGray
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func tabBarAppearance() {
        let tabBarAppearence = UITabBarItem.appearance()
        let attributedDict = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        tabBarAppearence.titlePositionAdjustment =  .init(horizontal: 0, vertical: -10)
        tabBarAppearence.setTitleTextAttributes(attributedDict, for: .normal)
        tabBarAppearence.setTitleTextAttributes(attributedDict, for: .selected)
    }
}

