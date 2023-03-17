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
        // MARK: 1. Capture the scene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // MARK: 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
        let window = UIWindow(windowScene: windowScene)

        // MARK: 3. Create a view hierarchy programmatically
        let viewController: UIViewController = Container.shared.mainBuilder().build()

        // MARK: 4. Set the root view controller of the window with your view controller
        window.rootViewController = viewController
        window.rootViewController?.modalPresentationStyle = .fullScreen

        // MARK: 5. Set the window and call makeKeyAndVisible()
        self.window = window
        Container.shared.window = window
        Container.shared.homeViewController = viewController

        UIView.animate(withDuration: 0.25, animations: {
            window.makeKeyAndVisible()
        })
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
