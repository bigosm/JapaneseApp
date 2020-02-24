//
//  PracticeCompletionViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 21/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class PracticeCompletionViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: PracticeCompletionViewModelType = PracticeCompletionViewModel()
    private let basicCellIdentifier = "basicCellIdentifier"
    private let practiceGroupCellIdentifier = "PracticeGroupCell"
    
    public var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = Theme.primaryBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(PracticeCompletionCell.self, forCellReuseIdentifier: self.practiceGroupCellIdentifier)
        
        self.navigationItem.hidesBackButton = true
        
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
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension PracticeCompletionViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.outputs.numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.practiceGroupCellIdentifier, for: indexPath) as! PracticeCompletionCell
        cell.configureWith(practiceAnswerAtIndex: indexPath.row)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension PracticeCompletionViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.inputs.select(practiceAnswerAtIndex: indexPath.row)

        // Nice and smoth selecting cell animation.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
