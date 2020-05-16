//
//  CharacterCollectionView.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class CharacterCollectionViewController: UIViewController, PracticeSubjectViewController {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: CharacterCollectionViewModelType = CharacterCollectionViewModel()
    private let cellIdentifier = "cellIdentifier"
    private var collectionHeightAnchor: NSLayoutConstraint?
    public var collectionView: UICollectionView {
        return self.view as! UICollectionView
    }

    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        self.view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.view.backgroundColor = Theme.Background.primaryColor
        
        self.collectionView.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.setupView()
        self.bindViewModel()
        self.viewModel.inputs.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.inputs.viewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.inputs.viewWillDisappear()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionHeightAnchor?.constant = self.collectionView.contentSize.height
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.contentUpdate.bind { [weak self] value in
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Position Layout
    
    private func setupView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionHeightAnchor = self.collectionView.heightAnchor.constraint(equalToConstant: self.collectionView.contentSize.height)
        self.collectionHeightAnchor?.isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension CharacterCollectionViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.outputs.numberOfItems
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! CharacterCollectionCell
        cell.configureWith(characterAtIndex: indexPath.row)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension CharacterCollectionViewController: UICollectionViewDelegate {
    
}


