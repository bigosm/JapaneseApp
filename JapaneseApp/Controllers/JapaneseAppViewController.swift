//
//  JapaneseAppViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class JapaneseAppViewController: UIViewController{
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.primaryBackgroundColor
    private var themeSecondaryBackgroundColor = Theme.secondaryBackgroundColor
    
    // MARK: - Instance Properties
    
    private let appSettings = AppSettings.shared
    
    public var tableView = UITableView(frame: .zero, style: .insetGrouped)
    fileprivate var selecectedCell: QuestionGroupCell?
    private var basicCellIdentifier = "basicCellIdentifier"
    private var questionGroupCellIdentifier = "QuestionGroupCell"

    private let characterTablesCaretaker = CharacterTablesCaretaker()
    private var characterTableList: [JACharacterTable] {
        return self.characterTablesCaretaker.characterTableList
    }
    private var selectedCharacterTable: JACharacterTable! {
        get { return self.characterTablesCaretaker.selectedCharacterTable }
        set { self.characterTablesCaretaker.selectedCharacterTable = newValue }
    }
    
    private let questionRepository = QuestionRepository()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Japanese App"
        self.tableView.backgroundColor = self.themeBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.basicCellIdentifier)
        self.tableView.register(QuestionGroupCell.self, forCellReuseIdentifier: self.questionGroupCellIdentifier)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "outline_more_horiz_black_36pt"),
            style: .plain,
            target: self,
            action: #selector(self.handleSettingsButton(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(self.handleAddQuestionButton(_:)))
        
        self.setupView()
    }
    
    // MARK: - Instance Methods
    
    @objc func handleSettingsButton(_ sender: Any) {
        let vc = AppSettingsViewController()
        vc.delegate = self
        self.navigationController?.present(
            UINavigationController(rootViewController: vc),
            animated: true,
            completion: nil)
    }
    
    @objc func handleAddQuestionButton(_ sender: Any) {
        let vc = CreateQuestionGroupViewController()
        vc.delegate = self
        self.navigationController?.present(
            UINavigationController(rootViewController: vc),
            animated: true,
            completion: nil)
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

extension JapaneseAppViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.characterTableList.count
        case 1: return self.questionRepository.numberOfQuestionGroups
        default:
            fatalError()
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.basicCellIdentifier, for: indexPath)
            let characterTable = self.characterTableList[indexPath.row]
            
            cell.textLabel?.text = characterTable.title
            cell.backgroundColor = self.themeSecondaryBackgroundColor
            
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.questionGroupCellIdentifier, for: indexPath) as! QuestionGroupCell

            cell.titleLabel.text = self.questionRepository.title(forQuestionGroupAt: indexPath.row)
            let questionLevel = self.questionRepository.level(forQuestionGroupAt: indexPath.row)
            cell.levelLabel.text = "Level \(questionLevel)"
            cell.startButtonHandler = { [weak self] in
                let vc = QuestionViewController()
                vc.delegate = self
                vc.questionStrategy = self?.questionRepository.questionStrategy(forQuestionGroupAt: indexPath.row)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cell.historyButtonHandler = { [weak self] in
                let vc = QuestionHistoryViewController()
                vc.questionGroupHandler = self?.questionRepository.questionGroupHandler(forQuestionGroupAt: indexPath.row)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        default:
            fatalError()
        }
        
    }
    
}

// MARK: - UITableViewDelegate

extension JapaneseAppViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Character tables"
        case 1: return "Question Groups"
        default: return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            self.selectedCharacterTable = self.characterTableList[indexPath.row]
            let vc = CharacterTableViewController()
            vc.delegate = self
            vc.characterTable = self.selectedCharacterTable
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            self.selecectedCell?.toggleBody()
            
            if let cell = tableView.cellForRow(at: indexPath) as? QuestionGroupCell {
                if self.selecectedCell == cell {
                    self.selecectedCell = nil
                } else {
                    cell.toggleBody()
                    self.selecectedCell = cell
                }
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        
        default:
            fatalError()
        }
    }
    
}

// MARK: - QuestionViewControllerDelegate

extension JapaneseAppViewController: QuestionViewControllerDelegate {
    
    public func questionViewController(_ controller: QuestionViewController, didCancel questionStrategy: QuestionStrategy) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ controller: QuestionViewController, didComplete questionStrategy: QuestionStrategy) {
        questionStrategy.completeQuestionGroup()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
}

// MARK: - QuestionViewControllerDelegate

extension JapaneseAppViewController: AppSettingsViewControllerDelegate {
    
    public func appSettingsViewControllerDidFinish(_ controller: AppSettingsViewController) {
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - CreateQuestionGroupViewControllerDelegate

extension JapaneseAppViewController: CreateQuestionGroupViewControllerDelegate {
    
    public func createQuestionGroupViewControllerDidCancel(_ controller: CreateQuestionGroupViewController) {
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    public func createQuestionGroupViewController(_ controller: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        self.questionRepository.addNewQuestionGroup(questionGroup)
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
}

// MARK: - CharacterTableViewControllerDelegate

extension JapaneseAppViewController: CharacterTableViewControllerDelegate {
    
    public func characterTableViewController(_ controller: CharacterTableViewController, didCancel characterTable: JACharacterTable) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    public func characterTableViewController(_ controller: CharacterTableViewController, didComplete characterTable: JACharacterTable) {
        self.navigationController?.popToViewController(self, animated: true)
    }

}
