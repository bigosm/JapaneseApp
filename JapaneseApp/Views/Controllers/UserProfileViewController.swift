//
//  UserProfileViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class UserProfileViewController: ScrollableContainerViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: UserProfileViewModelType = UserProfileViewModel()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        setupView()
        bindViewModel()
        viewModel.inputs.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.inputs.viewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Binding
    
    private func bindViewModel() { }
    
    // MARK: - Setup View
    
    private func setupView() {
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        stackView.spacing = 20
        
        addToStack(UserProfileAboutViewController())
    }
}
