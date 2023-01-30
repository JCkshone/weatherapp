//
//  AppLifecycleProtocol.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import UIKit

public typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]
public typealias NotificationInfo = [AnyHashable: Any]
public typealias OpenURLOptions = [UIApplication.OpenURLOptionsKey: Any]
public typealias ActivityRestoring = ([UIUserActivityRestoring]?) -> Void
public typealias FetchResult = (UIBackgroundFetchResult) -> Void

public protocol AppLifecycleProtocol {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    func application(_ app: UIApplication, open url: URL, options: OpenURLOptions) -> Bool
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ActivityRestoring) -> Bool
    
    func applicationDidEnterBackground(_ application: UIApplication)
    func applicationWillEnterForeground(_ application: UIApplication)
    func applicationDidBecomeActive(_ application: UIApplication)
    func applicationWillTerminate(_ application: UIApplication)
    
    func userNotificationCenter(
        _ app: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    )
    
    func application(
        _ app: UIApplication,
        didReceiveRemoteNotification notificationInfo: NotificationInfo,
        fetchCompletionHandler completionHandler: @escaping FetchResult
    )
    
    func application(
        _ app: UIApplication,
        handlerActionWithIdentifier identifier: String?,
        forRemoteNotification notificationInfo: NotificationInfo,
        completionHandler: @escaping () -> Void
    )
}

public extension AppLifecycleProtocol {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool { return true }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}
    func application(_ app: UIApplication, open url: URL, options: OpenURLOptions) -> Bool { return false }
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ActivityRestoring
    ) -> Bool { return false }
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
    
    func userNotificationCenter(
        _ app: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {}
    
    func application(
        _ app: UIApplication,
        didReceiveRemoteNotification notificationInfo: NotificationInfo,
        fetchCompletionHandler completionHandler: @escaping FetchResult
    ) {}
    
    func application(
        _ app: UIApplication,
        handlerActionWithIdentifier identifier: String?,
        forRemoteNotification notificationInfo: NotificationInfo,
        completionHandler: @escaping () -> Void
    ) {}
}

