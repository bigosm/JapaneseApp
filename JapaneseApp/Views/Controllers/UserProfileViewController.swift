//
//  UserProfileViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class UserProfileViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: UserProfileViewModelType = UserProfileViewModel()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.bindViewModel()
        self.viewModel.inputs.viewDidLoad()
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
    
    private func bindViewModel() {
        self.viewModel.outputs.title.addObserver(self, options: [.new]) { value, options in
            self.title = value
        }
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        
    }
}
