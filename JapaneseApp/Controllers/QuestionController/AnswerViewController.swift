//
//  AnswerViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 14/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class AnswerViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    public var collectionView: UICollectionView!
    private var basicCellIdentifier = "basicCellIdentifier"
    
    public var selectedAnswerHandler: ((String?) -> ())?
    public var selectedAnswer: String? {
        didSet { self.selectedAnswerHandler?(self.selectedAnswer) }
    }
    private var answerList: [String] = []
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let inset: CGFloat = 20
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - inset * 3) / 2
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: 200)
        flowLayout.minimumLineSpacing = inset
        flowLayout.minimumInteritemSpacing = inset
        flowLayout.scrollDirection = .vertical

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.allowsSelection = true
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        self.collectionView.register(AnswerCollectionCell.self, forCellWithReuseIdentifier: self.basicCellIdentifier)
        
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 420)
        ])
    }
    
    // MARK: - Instance methods
    
    public func configure(with answerList: [String]) {
        self.answerList = answerList
        self.selectedAnswer = nil
        self.collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension AnswerViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.basicCellIdentifier, for: indexPath) as! AnswerCollectionCell
        
        cell.configure(with: self.answerList[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension AnswerViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAnswer = self.answerList[indexPath.row]
        if selectedAnswer == self.selectedAnswer {
            self.selectedAnswer = nil
            self.collectionView.deselectItem(at: indexPath, animated: false)
        } else {
            self.selectedAnswer = selectedAnswer
        }
    }
    
}
