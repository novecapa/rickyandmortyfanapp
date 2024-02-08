//
//  SceneDelegate.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let container = Container.shared
        let window = UIWindow(windowScene: windowScene)
        let viewController: UIViewController = container.mainBuilder().build()
        window.rootViewController = viewController
        window.rootViewController?.modalPresentationStyle = .fullScreen

        self.window = window
        container.window = window
        container.homeViewController = viewController
        UIView.animate(withDuration: 0.25, animations: {
            window.makeKeyAndVisible()
        })
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
