//
//  QuestionViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

// MARK: - QuestionViewControllerDelegate

public protocol QuestionViewControllerDelegate: AnyObject {
    
    func questionViewController(
        _ controller: QuestionViewController,
        didCancel questionStrategy: QuestionStrategy)
    
    func questionViewController(
        _ controller: QuestionViewController,
        didComplete questionStrategy: QuestionStrategy)
    
}

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var questionStrategy: QuestionStrategy! {
        didSet {
            self.navigationItem.title = self.questionStrategy.title
        }
    }

    public weak var delegate: QuestionViewControllerDelegate?
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = item
        return item
    }()
    

    private var questionNavigationController = QuestionNavigationViewController()
    
    private var collectionView: UICollectionView!
    private var basicCellIdentifier = "basicCellIdentifier"

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "background")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.allowsSelection = true
        self.collectionView.isPagingEnabled = true
        self.collectionView.isScrollEnabled = false
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: self.basicCellIdentifier)
        
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.createView(with: [
            self.questionNavigationController
        ])

        
        let questionNavigationView = self.questionNavigationController.view!
        questionNavigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionNavigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            questionNavigationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            questionNavigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            questionNavigationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
        self.questionStrategy.currentQuestionAnswerObservable.addObserver(self, options: [.initial, .new]) { value, option  in
            self.questionNavigationController.checkButton.isEnabled = value != nil
        }
        
        self.questionNavigationController.skipButtonAction = { [weak self] in
            self?.showNextQuestion(skip: true)
        }
        
        self.questionNavigationController.checkButtonAction = { [weak self] in
            return self?.questionStrategy.checkAnswer()
        }
        
        self.questionNavigationController.continueButtonAction = { [weak self] in
            self?.showNextQuestion()
        }

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(self.handleCancelButton(_:)))
        
        self.showQuestion()
    }
    
    deinit {
        self.questionStrategy.currentQuestionAnswerObservable.removeObserver(self)
    }
    
    // MARK: - Instance Methods
    
    @objc func handleCancelButton(_ sender: Any) {
        self.delegate?.questionViewController(self, didCancel: self.questionStrategy)
    }

    // MARK: - Private Methods
    
    private func createView(with controllers: [UIViewController]) {
        controllers.forEach {
            self.addChild($0)
            self.view.addSubview($0.view)
            $0.didMove(toParent: self)
        }
    }
    
    private func showQuestion() {
        let question = self.questionStrategy.currentQuestion()
        self.questionIndexItem.title = self.questionStrategy.questionIndexTitle()
        self.questionNavigationController.set(correctAnswer: question.answer)
    }
    
    private func showNextQuestion(skip: Bool = false) {
        guard self.questionStrategy.advanceToNextQuestion(skip: skip) else {
            self.delegate?.questionViewController(self, didComplete: self.questionStrategy)
            return
        }
        
        let currentQuestionIndex = IndexPath(item: self.questionStrategy.currentQuestionIndex, section: 0)
        
        if skip {
            let lastQuestionIndex = IndexPath(item: self.questionStrategy.numberOfQuestions - 1, section: 0)
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [currentQuestionIndex])
                self.collectionView.insertItems(at: [lastQuestionIndex])
            }, completion: nil)
        }
        
        self.collectionView.scrollToItem(at: currentQuestionIndex, at: .left, animated: true)
        
        self.showQuestion()
    }

}

// MARK: - UICollectionViewDataSource

extension QuestionViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.questionStrategy.numberOfQuestions
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.basicCellIdentifier, for: indexPath) as! QuestionCell
        let question = self.questionStrategy.question(for: indexPath.item)
        let feed = self.questionStrategy.feedAnswersFor(question: question, amount: 4)
        
        cell.configure(with: question, feed: feed)
        
        cell.answerController.selectedAnswerHandler = { [weak self] selectedAnswer in
            self?.questionStrategy.currentQuestionAnswerObservable.value = selectedAnswer
        }
        
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension QuestionViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension QuestionViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
