//
//  AppDelegate.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/7/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if NetworkingService.shared.isAuthorized {
            
            guard
               let root = UIStoryboard(name:"Menu",
                                        bundle:Bundle.main)
                    .instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
                else { return true }
            
            if #available(iOS 13.0, *) {
                window?.rootViewController = root
            } else {
                let transition = CATransition()
                transition.type = CATransitionType.fade
                window?.set(rootViewController: root, withTransition: transition)
            }
        }
        return true
    }
}
