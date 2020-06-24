//
//  DrawingViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 27/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class DrawingViewController: UIViewController {
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - Instance methods
    
    @objc func didTapUndoButton() {
        canvas.undo()
    }
    
    // MARK: - View Properties
    
    lazy var canvas: Canvas = {
        let x = Canvas()
        x.backgroundColor = Theme.Background.secondaryColor
        x.strokeColor = .white
        x.lineWidth = 3.0
        x.layer.cornerRadius = 20
        x.clipsToBounds = true
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var toolContainer: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            undoButton,
            UIView()
        ])
        x.distribution = .equalSpacing
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var undoButton: Button = {
        let x = Button(customType: .primary)
        x.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        x.imageView?.contentMode = .scaleAspectFit
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        x.addTarget(self, action: #selector(didTapUndoButton), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: x.buttonHeight).isActive = true
        return x
    }()
    
    // MARK: - View Position Layout
    
    private func setupView() {
        view.addSubview(canvas)
        view.addSubview(toolContainer)
        
        let padding = Theme.Size.Padding.thin
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toolContainer.bottomAnchor.constraint(equalTo: canvas.bottomAnchor, constant: -padding),
            toolContainer.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: padding),
            toolContainer.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -padding),
            toolContainer.heightAnchor.constraint(equalToConstant: undoButton.buttonHeight),
        ])
    }
}
