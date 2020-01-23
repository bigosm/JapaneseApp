//
//  QuestionHistoryViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class QuestionHistoryViewController: UIViewController {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.primaryBackgroundColor
    
    // MARK: - Instance Properties
    
    public var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var basicCellIdentifier = "basicCellIdentifier"
    
    public var questionGroupHandler: QuestionGroupHandler!
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.questionGroupHandler.questionGroup.title
        self.tableView.backgroundColor = self.themeBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(QuestionHistoryCell.self, forCellReuseIdentifier: self.basicCellIdentifier)
        
        self.setupView()
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

extension QuestionHistoryViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(self.questionGroupHandler.questionGroupAnswersData.questionGroupAnswers[section].startDate)"
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.questionGroupHandler.questionGroupAnswersData.questionGroupAnswers.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionGroupHandler.questionGroupAnswersData.questionGroupAnswers[section].questionAnswers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.basicCellIdentifier, for: indexPath) as! QuestionHistoryCell
        let questionAnswer = self.questionGroupHandler.questionGroupAnswersData
            .questionGroupAnswers[indexPath.section]
            .questionAnswers[indexPath.row]
        
        cell.titleLabel.text = questionAnswer.question.prompt
        cell.selectedAnswerLabel.text = questionAnswer.selectedAnswer
        cell.isCorrect = questionAnswer.isCorrect
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension QuestionHistoryViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
