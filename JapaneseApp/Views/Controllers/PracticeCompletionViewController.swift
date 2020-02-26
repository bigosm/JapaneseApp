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
    private let completionQuestionCell = "completionQuestionCell"
    private let completionSummaryCell = "completionSummaryCell"
    
    public var tableView = UITableView()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.primaryBackgroundColor
        self.tableView.backgroundColor = Theme.primaryBackgroundColor
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.isUserInteractionEnabled = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(PracticeCompletionCell.self, forCellReuseIdentifier: self.completionQuestionCell)
        self.tableView.register(PracticeCompletionSummaryCell.self, forCellReuseIdentifier: self.completionSummaryCell)
        
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.viewModel.outputs.numberOfItems
        case 1: return 1
        default: return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.completionSummaryCell, for: indexPath) as! PracticeCompletionSummaryCell
            cell.configure()
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.completionQuestionCell, for: indexPath) as! PracticeCompletionCell
            cell.configureWith(practiceAnswerAtIndex: indexPath.row)
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension PracticeCompletionViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        self.viewModel.inputs.select(practiceAnswerAtIndex: indexPath.row)

        // Nice and smoth selecting cell animation.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
