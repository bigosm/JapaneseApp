//
//  CreateQuestionGroupViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 09/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

// MARK: - CreateQuestionGroupViewControllerDelegate

public protocol CreateQuestionGroupViewControllerDelegate: AnyObject {
    
    func createQuestionGroupViewControllerDidCancel(
        _ controller: CreateQuestionGroupViewController)
    
    func createQuestionGroupViewController(
        _ controller: CreateQuestionGroupViewController,
        created questionGroup: QuestionGroup)
    
}

public class CreateQuestionGroupViewController: UIViewController {
    
    // MARK: - Theme
    
    private var themeBackgroundColor = Theme.primaryBackgroundColor
    
    // MARK: - Instance Properties
    
    public weak var delegate: CreateQuestionGroupViewControllerDelegate?
    public var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let textFieldCellIdentifier = "textFieldCellIdentifier"
    private let basicCellIdentifier = "basicCellIdentifier"
    
    public let questionGroupBuilder = QuestionGroupBuilder()
    fileprivate var numberOfQuestions: Int { return self.questionGroupBuilder.questions.count }
    
    // MARK: - View Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Question Group"
        self.tableView.backgroundColor = self.themeBackgroundColor
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(TextFieldCell.self, forCellReuseIdentifier: self.textFieldCellIdentifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.basicCellIdentifier)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(self.handleCancelButton(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(self.handleSaveButton(_:)))
        
        self.setupView()
    }
    
    // MARK: - Instance Methods
    
    @objc func handleCancelButton(_ sender: Any) {
        self.delegate?.createQuestionGroupViewControllerDidCancel(self)
    }
    
    @objc func handleSaveButton(_ sender: Any) {
        do {
            let questionGroup = try self.questionGroupBuilder.build()
            self.delegate?.createQuestionGroupViewController(self, created: questionGroup)
        } catch let error {
            print(error)
            self.displayMissingInputsAlert()
        }
    }
    
    public func displayMissingInputsAlert() {
        let alert = UIAlertController(
            title: "Missing Inputs",
            message: "Please provide all non-optional vlaues",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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

extension CreateQuestionGroupViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + self.numberOfQuestions
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1...self.numberOfQuestions:
            return 3
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.titleCell(from: tableView, for: indexPath)
        case 1...self.numberOfQuestions:
            return self.questionCell(from: tableView, for: indexPath)
        case self.numberOfQuestions + 1:
            return self.addNewQuestionCell(from: tableView, for: indexPath)
        default: fatalError()
        }
    }
    
    // MARK: Helpers
    
    private func titleCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return self.textFieldCell(from: tableView, for: indexPath,
                                  placeholder: "Question group title",
                                  value: self.questionGroupBuilder.title) { [weak self] text in
                                    self?.questionGroupBuilder.title = text
        }
    }
    
    private func questionCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let questionBuilder = self.questionGroupBuilder.questions[indexPath.section - 1]
        
        switch indexPath.row {
        case 0:
            return self.textFieldCell(from: tableView, for: indexPath,
                                      placeholder: "Prompt",
                                      value: questionBuilder.prompt) { text in
                                        questionBuilder.prompt = text
            }
        case 1:
            return self.textFieldCell(from: tableView, for: indexPath,
                                      placeholder: "Hint (Optional)",
                                      value: questionBuilder.hint) { text in
                                        questionBuilder.hint = text
            }
        case 2:
            return self.textFieldCell(from: tableView, for: indexPath,
                                      placeholder: "Answer",
                                      value: questionBuilder.answer) { text in
                                        questionBuilder.answer = text
            }
        default: fatalError()
        }
    }
    
    private func textFieldCell(from tableView: UITableView, for indexPath: IndexPath,
                               placeholder: String,
                               value: String,
                               textDidChange: @escaping (String) -> ()) -> TextFieldCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.textFieldCellIdentifier, for: indexPath) as! TextFieldCell
        
        if indexPath.section == 0 {
            cell.textField.becomeFirstResponder()
        }
        
        cell.selectionStyle = .none
        cell.textField.text = value
        cell.placeholder = placeholder
        cell.textDidChange = textDidChange
        
        return cell
    }
    
    private func addNewQuestionCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.basicCellIdentifier, for: indexPath)
    
        cell.textLabel?.text = "Add new question"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = self.view.tintColor
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CreateQuestionGroupViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.isLastSection(indexPath) {
            self.questionGroupBuilder.addNewQuestion()
            tableView.insertSections(IndexSet(integer: indexPath.section), with: .automatic)
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? TextFieldCell {
            cell.textField.becomeFirstResponder()
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Question group title"
        case 1...self.numberOfQuestions:
            return "Question \(section)"
        default: return nil
        }
    }
    
    // MARK: Helpers
    
    private func isLastSection(_ indexPath: IndexPath) -> Bool {
        return (indexPath.section + 1) == tableView.numberOfSections
    }
    
}
