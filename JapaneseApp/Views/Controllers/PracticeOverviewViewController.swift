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
    
    private let disposeBag = DisposeBag()
    private let viewModel: PracticeOverviewViewModelType

    // MARK: - View Lifecycle
    
    init(practiceType: PracticeType) {
        viewModel = PracticeOverviewViewModel(practiceType: practiceType)
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.inputs.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Bindings
    
    private func bindViewModel() {
        viewModel.outputs.numberOfItems.bind(.update) { [weak self] _ in
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = Theme.Background.primaryColor
        self.tableView.isUserInteractionEnabled = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(PracticeGroupCell.self)
    }
    
}

// MARK: - UITableViewDataSource

extension PracticeOverviewViewController {

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.outputs.numberOfItems.value
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withClass: PracticeGroupCell.self, for: indexPath)
        cell.configureWith(practiceGroupAtIndex: indexPath.row)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension PracticeOverviewViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.inputs.select(practiceGroupAtIndex: indexPath.row)

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

