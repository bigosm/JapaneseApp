//
//  SelectQuestionGroupViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class SelectQuestionGroupViewController: UIViewController{
    
    // MARK: - Instance Properties
    
    private let appSettings = AppSettings.shared
    
    public var tableView = UITableView()
    private var questionGroupCellId = "QuestionGroupCell"
    
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return self.questionGroupCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get { return self.questionGroupCaretaker.selectedQuestionGroup }
        set { self.questionGroupCaretaker.selectedQuestionGroup = newValue }
    }

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Question Groups"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(QuestionGroupCell.self, forCellReuseIdentifier: self.questionGroupCellId)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "outline_more_horiz_black_36pt"),
            style: .plain,
            target: self,
            action: #selector(self.handleSettingsButton(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(self.handleAddQuestionButton(_:)))
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

}

// MARK: - UITableViewDataSource

extension SelectQuestionGroupViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.questionGroupCellId, for: indexPath) as! QuestionGroupCell
        let questionGroup = self.questionGroups[indexPath.row]

        cell.titleLabel.text = questionGroup.title
        
        questionGroup.score.runningPercentage.addObserver(cell, options: [.initial, .new]) { [weak cell] percentage, _ in
            DispatchQueue.main.async {
                cell?.percentageLabel.text = String(format: "%.0f %%", round(100 * percentage))
            }
        }

        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SelectQuestionGroupViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.selectedQuestionGroup = self.questionGroups[indexPath.row]
        
        let vc = QuestionViewController()
        vc.delegate = self
        vc.questionStrategy = self.appSettings.questionStrategy(for: self.questionGroupCaretaker)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - QuestionViewControllerDelegate

extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    
    public func questionViewController(_ controller: QuestionViewController, didCancel questionStrategy: QuestionStrategy) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ controller: QuestionViewController, didComplete questionStrategy: QuestionStrategy) {
        self.navigationController?.popToViewController(self, animated: true)
    }

}

// MARK: - QuestionViewControllerDelegate

extension SelectQuestionGroupViewController: AppSettingsViewControllerDelegate {

    public func appSettingsViewControllerDidFinish(_ controller: AppSettingsViewController) {
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }

}

// MARK: - CreateQuestionGroupViewControllerDelegate

extension SelectQuestionGroupViewController :CreateQuestionGroupViewControllerDelegate {
    
    public func createQuestionGroupViewControllerDidCancel(_ controller: CreateQuestionGroupViewController) {
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    public func createQuestionGroupViewController(_ controller: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        self.questionGroupCaretaker.questionGroups.append(questionGroup)
        try? self.questionGroupCaretaker.save()
        
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        self.tableView.reloadData()
    }

}
