//
//  SceneDelegate.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/15/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        // MARK: - Start programmatic UI. Set up Scene
        //Replace underscore with a variable name. Below is the initial set up to get rid of storyboard and the intial view controller to set up
        guard let windowScene = (scene as? UIWindowScene) else { return }
        //Need to capture the windowScene which is the area on the screen which we can add stuff to it.
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
//        Need to set the root view controller for our window
        window?.rootViewController = createTabBar()
        //Tell the application to make the window visible on the screen
        window?.makeKeyAndVisible()
    }
    
    
    func createSearchNavigationController() -> UINavigationController {
        let vc = DigmonCharacterViewController()
        vc.tabBarItem = UITabBarItem(title: "Digimon", image: UIImage(systemName: "list.dash"), tag: 0)
        
        //Put are ViewController within a UI navigation controller. Will be able to put your view inside of as a contain and add buttons and navbar, etc.
        return UINavigationController(rootViewController: vc)
        
    }
    
    func createFavoritesNagivationController() -> UINavigationController {
        let favController = FavoritesListViewController()
        favController.navigationItem.title = "Favorites"
        favController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favController)
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        //Need to put the View Controllers into the Tab bar. Which is an array of View Controllers
        tabBar.viewControllers = [createSearchNavigationController(), createFavoritesNagivationController()]
        
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

