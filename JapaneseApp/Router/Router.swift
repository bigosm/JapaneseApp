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
    
    var windowLogin: UIWindow!
    var windowMain: UIWindow!
    var windowSplashScreen: UIWindow!
    
    var navigationPractice: UINavigationController?
    var navigationProfile: UINavigationController?
    
    var tabBarMain: UITabBarController!
    
    func configureWith(windowScene: UIWindowScene) {
        self.windowScene = windowScene

        let splashScreen = SplashScreen.instance
        windowSplashScreen = newWindow(splashScreen, level: 2)
        windowSplashScreen?.makeKeyAndVisible()
        
        splashScreen.animate {
            AppStore.shared.subscribe(self) {
                $0.select { $0 }
            }
        }
        
        windowLogin = newWindow(LoginViewController(), level: 1)
        
        tabBarMain =  newTabBarMain()
        windowMain = newWindow(tabBarMain, level: 0)

        _ = AppStore.shared.state
    }
    
    func newState(state: AppState) {
        let navigationSate = state.navigationState
        
        guard case .authorized = state.userSessionState else {
            setWindowCurrentKeyAndVisible(windowLogin)
            return
        }
        
        setWindowCurrentKeyAndVisible(windowMain)
        
        switch navigationSate.routeToView {
        case .practiceOverview:
            navigationPractice?.popToRootViewController(animated: true)
            tabBarMain.tabBar.isHidden = false
            tabBarMain.tabBar.isUserInteractionEnabled = true
        case .practice:
            let vc = PracticeFlashcardViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationPractice?.pushViewController(vc, animated: true)
//            tabBarMain.tabBar.isHidden = true
//            tabBarMain.tabBar.isUserInteractionEnabled = false
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
    
    private func setWindowCurrentKeyAndVisible(_ window: UIWindow) {
        guard !window.isKeyWindow else { return }
        let current = windowScene.windows.first { $0.isKeyWindow }
        window.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            current?.alpha = 0.0
        }, completion: { _ in
            window.makeKeyAndVisible()
            current?.isHidden = true
            current?.alpha = 1.0
        })
        print("💖")
    }
    
    private func newWindow(_ rootViewController: UIViewController, level: CGFloat) -> UIWindow {
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        window.windowLevel = .init(level)
        window.isHidden = true
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
        navigationPractice = newNavigationController(PracticeOverviewViewController(practiceType: .hiragana))
        navigationPractice?.tabBarItem = UITabBarItem(title: "Practice", image: AppImage.tabPractice, tag: 0)
        
        navigationProfile = newNavigationController(UserProfileViewController())
        navigationProfile?.tabBarItem = UITabBarItem(title: "Profile", image: AppImage.tabProfile, tag: 1)
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            navigationPractice!,
            navigationProfile!,
        ]
        
        tabBar.tabBar.barTintColor = Theme.Background.primaryColor
        tabBar.tabBar.isTranslucent = false
        tabBar.tabBar.tintColor = Theme.primaryColor
        
        tabBar.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.tabBar.layer.shadowRadius = 10
        tabBar.tabBar.layer.shadowColor = Theme.Background.secondaryColor?.cgColor
        tabBar.tabBar.layer.shadowOpacity = 0.5
        
        return tabBar
    }
}
