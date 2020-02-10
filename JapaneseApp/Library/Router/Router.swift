//
//  Router.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import ReSwift

public class Router: StoreSubscriber {
    public typealias StoreSubscriberStateType = NavigationState

    public static let shared = Router()
    public let mainNavigationController: UINavigationController
    
    public var window: UIWindow?

    private init() {
        self.mainNavigationController = UINavigationController(rootViewController: PracticeOverviewViewController())
        self.mainNavigationController.navigationBar.tintColor = UIColor(named: "primaryColor")
    }
    
    public func configureWith(window: UIWindow?) {
        self.window = window
        self.window?.rootViewController = self.mainNavigationController
        
        AppStore.shared.subscribe(self) {
            $0.select { $0.navigationState }
        }
    }
    
    public func newState(state: NavigationState) {
        switch state.currentView {
        case .practiceOverview:
            self.mainNavigationController.popToRootViewController(animated: true)
        case .practice:
            let vc = PracticeViewController()
            self.mainNavigationController.pushViewController(vc, animated: true)
        }
    }
    
}
