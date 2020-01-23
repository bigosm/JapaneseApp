//
//  AppSettingsViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

// MARK: - AppSettingsViewControllerDelegate

public protocol AppSettingsViewControllerDelegate: AnyObject {
    
    func appSettingsViewControllerDidFinish(
        _ controller: AppSettingsViewController)
    
}

public class AppSettingsViewController: UIViewController {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.primaryBackgroundColor
    private var themeSecondaryBackgroundColor = Theme.secondaryBackgroundColor
    
    // MARK: - Instance Properties
    
    public var tableView = UITableView(frame: .zero, style: .insetGrouped)
    weak var delegate: AppSettingsViewControllerDelegate?
    
    public let appSettings = AppSettings.shared
    private let cellIdentifier = "basicCell"
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        self.tableView.backgroundColor = self.themeBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(self.handleDoneButton(_:)))
        
        self.setupView()
    }
    
    //MARK: - Instance Methods
    
    @objc func handleDoneButton(_ sender: Any) {
        self.delegate?.appSettingsViewControllerDidFinish(self)
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

extension AppSettingsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        
        cell.textLabel?.text = questionStrategyType.title
        cell.backgroundColor = self.themeSecondaryBackgroundColor
        
        if self.appSettings.questionStrategyType == questionStrategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension AppSettingsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.appSettings.questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Question order"
    }
    
}
