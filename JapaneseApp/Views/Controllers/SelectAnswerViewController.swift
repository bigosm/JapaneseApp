//
//  SelectAnswerViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 26/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class SelectAnswerViewController: UIViewController, PracticeAnswerViewController {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: SelectAnswerViewModelType = SelectAnswerViewModel()

    private var basicCellIdentifier = "basicCellIdentifier"
    public var tableView = UITableView()

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = Theme.primaryBackgroundColor
        self.tableView.isUserInteractionEnabled = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
        self.tableView.register(SelectAnswerCell.self, forCellReuseIdentifier: self.basicCellIdentifier)
        
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
        viewModel.outputs.contentUpdate.bind { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
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

extension SelectAnswerViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.outputs.numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.basicCellIdentifier, for: indexPath) as! SelectAnswerCell
        cell.configureWith(answerFeedAtIndex: indexPath.row)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SelectAnswerViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.inputs.select(answerAtIndex: indexPath.row)
    }
    
}
