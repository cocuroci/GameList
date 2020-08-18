//
//  SceneDelegate.swift
//  GameList
//
//  Created by André Martins on 21/07/20.
//  Copyright © 2020 André Cocuroci. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let context = CoreDataContainer.shared.context
        let gameList = GameListViewCoreData()
            .environment(\.managedObjectContext, context)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: gameList)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataContainer.shared.saveContext()
    }
}

