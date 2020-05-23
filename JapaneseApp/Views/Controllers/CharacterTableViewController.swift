//
//  CharacterTableViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 13/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

// MARK: - CharacterTableViewControllerDelegate

public protocol CharacterTableViewControllerDelegate: AnyObject {
    
    func characterTableViewController(
        _ controller: CharacterTableViewController,
        didCancel characterTable: KanaCharacters)
    
    func characterTableViewController(
        _ controller: CharacterTableViewController,
        didComplete characterTable: KanaCharacters)
    
}

public class CharacterTableViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private var basicCellIdentifier = "basicCellIdentifier1"
    public var tableView = UITableView(frame: .zero, style: .insetGrouped)
    public var characterTable: KanaCharacters!
    public weak var delegate: CharacterTableViewControllerDelegate?

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = Theme.Background.primaryColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.setupView()
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

extension CharacterTableViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.basicCellIdentifier) ??
            UITableViewCell(style: .value1, reuseIdentifier: self.basicCellIdentifier)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CharacterTableViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
