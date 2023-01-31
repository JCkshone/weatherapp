//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import UIKit

@main
final class AppDelegate: NSObject, UIApplicationDelegate {
    let appRegistry = AppRegistry()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions?
    ) -> Bool {
        appRegistry.getRegistry().forEach {
            let result = $0.application(application, didFinishLaunchingWithOptions: launchOptions)
            if !result {
                debugPrint("[Error initialized] Registry")
            }
        }

        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sessionRole = connectingSceneSession.role
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
