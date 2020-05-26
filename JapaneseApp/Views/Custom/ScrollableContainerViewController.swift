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
    
    var axis: NSLayoutConstraint.Axis = .vertical {
        didSet { setScrollableContainerTo(axis) }
    }
    
    // MARK: - View Lifecycle
    
    public override func loadView() {
        view = scrollView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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
    
    private func setScrollableContainerTo(_ axis: NSLayoutConstraint.Axis) {
        stackView.axis = axis
        
        NSLayoutConstraint.deactivate(stackView.constraints)
        NSLayoutConstraint.activate(axis == .vertical ? vertialStackConstraints : horizontalStackConstraints)
    }

    // MARK: - Setup View
    
    lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    lazy var stackView: UIStackView = {
        let x = UIStackView()
        x.axis = axis
        x.alignment = .fill
        x.distribution = .equalSpacing
        x.spacing = 0
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var vertialStackConstraints: [NSLayoutConstraint] = {
        return [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ]
    }()
    
    private lazy var horizontalStackConstraints: [NSLayoutConstraint] = {
        return [
            stackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor),
        ]
    }()

    private func setupView() {
        scrollView.addSubview(stackView)
        setScrollableContainerTo(axis)
    }

}
