//
//  ETH_GasApp.swift
//  ETH Gas
//
//  Created by Maxence Mottard on 08/10/2022.
//

import SwiftUI
import WidgetKit

@main
struct ETH_GasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self

        return config
    }
}

private class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneDidBecomeActive(_ scene: UIScene) {
        WidgetCenter.shared.reloadAllTimelines()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
