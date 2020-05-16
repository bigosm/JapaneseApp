//
//  Router.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import ReSwift

class Router: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    static let shared = Router()
    
    var windowScene: UIWindowScene!
    
    var windowLogin: UIWindow?
    var windowMain: UIWindow?
    var windowSplashScreen: UIWindow?
    
    var navigationPractice: UINavigationController?
    var navigationProfile: UINavigationController?
    
    var tabBarMain: UITabBarController?
    
    func configureWith(windowScene: UIWindowScene) {
        self.windowScene = windowScene

        let splashScreen = SplashScreen.instance
        windowSplashScreen = newWindow(splashScreen)
        windowSplashScreen?.makeKeyAndVisible()
        splashScreen.animate {
            AppStore.shared.subscribe(self) {
                $0.select { $0 }
            }
        }
    }
    
    func newState(state: AppState) {
        let navigationSate = state.navigationState
        
        guard case .authorized = state.userSessionState else {
            let windowLogin = self.windowLogin ?? newWindow(LoginViewController())
            windowLogin.makeKeyAndVisible()
            self.windowLogin = windowLogin
            return
        }
        
        let tabBarMain = self.tabBarMain ?? newTabBarMain()
        self.tabBarMain = tabBarMain
        
        let windowMain = self.windowMain ?? newWindow(tabBarMain)
        self.windowMain = windowMain
        windowMain.makeKeyAndVisible()

        switch navigationSate.routeToView {
        case .practiceOverview:
            navigationPractice?.popToRootViewController(animated: true)
            tabBarMain.tabBar.isHidden = false
            tabBarMain.tabBar.isUserInteractionEnabled = true
        case .practice:
            let vc = PracticeViewController()
            navigationPractice?.pushViewController(vc, animated: true)
            tabBarMain.tabBar.isHidden = true
            tabBarMain.tabBar.isUserInteractionEnabled = false
        case .practiceCompletion:
            let vc = PracticeCompletionViewController()
            navigationPractice?.pushViewController(vc, animated: true)
            tabBarMain.tabBar.isHidden = true
            tabBarMain.tabBar.isUserInteractionEnabled = false
        case .none:
            break
        }
    }
    
    // MARK: - Private methods
    
    private func newWindow(_ rootViewController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        window.rootViewController = rootViewController
        window.backgroundColor = Theme.Background.primaryColor
        return window
    }
    
    private func newNavigationController(_ rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.isNavigationBarHidden = true
        return nav
    }
    
    private func newTabBarMain() -> UITabBarController {
        navigationPractice = newNavigationController(PracticeOverviewViewController())
        navigationPractice?.tabBarItem = UITabBarItem(title: nil, image: AppImage.tabPractice, tag: 0)
        
        navigationProfile = newNavigationController(UserProfileViewController())
        navigationProfile?.tabBarItem = UITabBarItem(title: nil, image: AppImage.tabProfile, tag: 1)
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            navigationPractice!,
            navigationProfile!,
        ]
        return tabBar
    }
}
