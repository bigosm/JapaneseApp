//
//  LoadingIndicator.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 17/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    var hidesWhenStopped = true
        
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        isHidden = false
        let delay = 0.2
        let duration = Double(container.arrangedSubviews.count) * delay
        
        container.arrangedSubviews.enumerated().forEach { item in
            UIView.animate(withDuration: Double(duration), delay: Double(item.offset) * delay, options: [.repeat, .autoreverse], animations: {
                item.element.alpha = 1
            }, completion: nil)
        }
    }
    
    func stopAnimating() {
        container.arrangedSubviews.forEach {
            $0.layer.removeAllAnimations()
            $0.alpha = 0
        }
        isHidden = hidesWhenStopped
    }
    
    lazy var indicatorLabel: UILabel = {
        let x = UILabel()
        x.text = "Please wait"
        x.textColor = Theme.Text.Color.secondary
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var container: UIStackView = {
        let x = UIStackView(arrangedSubviews: [itemView, itemView, itemView])
        x.axis = .horizontal
        x.distribution = .equalSpacing
        x.spacing = 5
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    var itemView: UIView {
        let x = UIView()
        let dotSize = 4 as CGFloat
        x.backgroundColor = Theme.Text.Color.primary
        x.layer.cornerRadius = dotSize / 2
        x.alpha = 0
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        x.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        return x
    }
    
    private func setupView() {
        addSubview(indicatorLabel)
        addSubview(container)
        
        NSLayoutConstraint.activate([
            indicatorLabel.topAnchor.constraint(equalTo: topAnchor),
            indicatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicatorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            container.topAnchor.constraint(equalTo: indicatorLabel.bottomAnchor, constant: 5),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
