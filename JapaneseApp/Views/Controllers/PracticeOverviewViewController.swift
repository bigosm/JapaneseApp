//
//  JapaneseAppViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import ReSwift

public final class PracticeOverviewViewController: UIViewController, StoreSubscriber {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.primaryBackgroundColor
    private var themeSecondaryBackgroundColor = Theme.secondaryBackgroundColor
    
    // MARK: - Instance Properties
    fileprivate var selecectedCell: QuestionGroupCell?

    public var tableView = UITableView()
    
    private var basicCellIdentifier = "basicCellIdentifier"
    private var questionGroupCellIdentifier = "QuestionGroupCell"
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Japanese App"
        self.tableView.backgroundColor = self.themeBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(QuestionGroupCell.self, forCellReuseIdentifier: self.questionGroupCellIdentifier)
        
        self.setupView()
    }
    
    public func newState(state: RepositoryState) {
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Instance Methods
    
    
    
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
        return AppStore.shared.state.repositoryState.numberOfQuestionGroups
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.questionGroupCellIdentifier, for: indexPath) as! QuestionGroupCell

        cell.configureWith(questionGroupAtIndex: indexPath.row)

        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension PracticeOverviewViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = true
        
//        AppStore.shared.dispatch(SelectQuestionGroup(indexOf: indexPath.row))

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
}

