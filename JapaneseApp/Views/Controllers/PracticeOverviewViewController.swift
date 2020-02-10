//
//  JapaneseAppViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import ReSwift

public final class PracticeOverviewViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: PracticeOverviewViewModelType = PracticeOverviewViewModel()
    private let basicCellIdentifier = "basicCellIdentifier"
    private let practiceGroupCellIdentifier = "PracticeGroupCell"
    
    public var tableView = UITableView()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Japanese App"
        self.tableView.backgroundColor = Theme.primaryBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(PracticeGroupCell.self, forCellReuseIdentifier: self.practiceGroupCellIdentifier)
        
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
    
    // MARK: - Bindings
    
    private func bindViewModel() { }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension PracticeOverviewViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.outputs.numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.practiceGroupCellIdentifier, for: indexPath) as! PracticeGroupCell
        cell.configureWith(practiceGroupAtIndex: indexPath.row)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension PracticeOverviewViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.inputs.select(practiceGroupAtIndex: indexPath.row)

        // Nice and smoth selecting cell animation.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

