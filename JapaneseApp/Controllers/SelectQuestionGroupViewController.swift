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
    
    var tableView = UITableView()
    var questionGroupCellId = "QuestionGroupCell"
    
    var questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
    
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
        vc.questionGroup = self.selectedQuestionGroup
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ controller: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ controller: QuestionViewController, didComplete questionGroup: QuestionGroup) {
        self.navigationController?.popToViewController(self, animated: true)
    }

}
