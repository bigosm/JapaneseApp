//
//  ScrollableContainerViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class ScrollableContainerViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    var scrollView: UIScrollView {
        guard let view = view as? UIScrollView else {
            fatalError("View should be an instance of UIScrollView")
        }
        return view
    }
    
    // MARK: - View Lifecycle
    
    public override func loadView() {
        self.view = UIScrollView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    // MARK: - Instance Methods
    
    func addToStack(_ viewController: UIViewController) {
        addChild(viewController)
        stackView.addArrangedSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeFromStack(_ viewController: UIViewController) {
        viewController.removeFromParent()
        viewController.didMove(toParent: nil)
    }
    
    // MARK: - Binding
    
    // MARK: - View Position Layout
    
    private func setupView() {
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
