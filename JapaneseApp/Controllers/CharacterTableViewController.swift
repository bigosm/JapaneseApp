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
        didCancel characterTable: JACharacterTable)
    
    func characterTableViewController(
        _ controller: CharacterTableViewController,
        didComplete characterTable: JACharacterTable)
    
}

public class CharacterTableViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public weak var delegate: CharacterTableViewControllerDelegate?
    public var tableView = UITableView()
    private var basicCellIdentifier = "basicCellIdentifier1"
    
    public var characterTable: JACharacterTable!

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.characterTable.title
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

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
        return self.characterTable.characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.basicCellIdentifier) ??
            UITableViewCell(style: .value1, reuseIdentifier: self.basicCellIdentifier)
        let character = self.characterTable.characters[indexPath.row]

        cell.textLabel?.text = character.character
        cell.textLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        cell.detailTextLabel?.text = character.phonetic
        
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
