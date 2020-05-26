//
//  JapaneseAppViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import ReSwift

final class PracticeOverviewViewController: TableViewController {
    
    // MARK: - Instance Properties
    
    private var disposeBag = DisposeBag()
    private let viewModel: PracticeOverviewViewModelType

    // MARK: - View Lifecycle
    
    init(practiceType: PracticeType) {
        viewModel = PracticeOverviewViewModel(practiceType: practiceType)
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputs.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Bindings
    
    private func bindViewModel() {
        viewModel.outputs.numberOfItems.bind(.update) { [weak self] _ in
            if self?.view.window?.isKeyWindow ?? false {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isLoading.bind(.update) { [weak self] isLoading in
            isLoading
                ? self?.loadingIndicator.startAnimating()
                : self?.loadingIndicator.stopAnimating()
        }.disposed(by: disposeBag)
    }
    
    lazy var loadingIndicator: LoadingIndicatorView = {
        let x = LoadingIndicatorView()
        tableView.addSubview(x)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        x.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return x
    }()
    
    // MARK: - Setup View
    
    private func setupView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = Theme.Background.primaryColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PracticeGroupCell.self)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension PracticeOverviewViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.outputs.numberOfItems.value
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView
            .dequeueReusableCell(withClass: PracticeGroupCell.self, for: indexPath)
            .configure(
                viewModel.outputs.practiceType,
                withPracticeGroupAtIndex: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.practiceGroupTapped(atIndex: indexPath.row)
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
