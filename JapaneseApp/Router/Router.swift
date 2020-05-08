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
    typealias StoreSubscriberStateType = NavigationState

    static let shared = Router()
    
    let mainTabBarController = UITabBarController()
    
    let practiceNavigationController = UINavigationController()
    let profileNavigationController = UINavigationController()

    var window: UIWindow?

    private init() {
        practiceNavigationController.viewControllers = [PracticeOverviewViewController()]
        practiceNavigationController.navigationBar.tintColor = Theme.primaryColor
        practiceNavigationController.navigationBar.backgroundColor = Theme.secondaryBackgroundColor
        practiceNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage.App.practiceTab.image, tag: 0)
        
        profileNavigationController.navigationBar.tintColor = Theme.primaryColor
        profileNavigationController.navigationBar.backgroundColor = Theme.secondaryBackgroundColor
        profileNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage.App.profileTab.image, tag: 1)
        
        mainTabBarController.viewControllers = [
            practiceNavigationController,
            profileNavigationController,
        ]
    }
    
     func configureWith(window: UIWindow?) {
        self.window = window
        
        guard let window = window else { return }
        
        window.rootViewController = mainTabBarController
        
        let splashScreen = SplashScreen.instance
        
        mainTabBarController.view.addSubview(splashScreen.view)
        mainTabBarController.addChild(splashScreen)
        splashScreen.didMove(toParent: mainTabBarController)
        splashScreen.animate {
            splashScreen.view.removeFromSuperview()
            splashScreen.removeFromParent()
            splashScreen.didMove(toParent: nil)
        }
        
        AppStore.shared.subscribe(self) {
            $0.select { $0.navigationState }
        }
    }
    
    func newState(state: NavigationState) {
        switch state.routeToView {
        case .practiceOverview:
            practiceNavigationController.popToRootViewController(animated: true)
            mainTabBarController.tabBar.isHidden = false
            mainTabBarController.tabBar.isUserInteractionEnabled = true
        case .practice:
            let vc = PracticeViewController()
            practiceNavigationController.pushViewController(vc, animated: true)
            mainTabBarController.tabBar.isHidden = true
            mainTabBarController.tabBar.isUserInteractionEnabled = false
        case .practiceCompletion:
            let vc = PracticeCompletionViewController()
            practiceNavigationController.pushViewController(vc, animated: true)
            mainTabBarController.tabBar.isHidden = true
            mainTabBarController.tabBar.isUserInteractionEnabled = false
        case .none:
            break
        }
    }
}
