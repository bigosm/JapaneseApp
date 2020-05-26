//
//  PracticeGroupCell.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class PracticeGroupCell: TableViewCell {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: PracticeGroupViewModelType = PracticeGroupViewModel()
        
    // MARK: - Object Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Theme.Background.primaryColor
        selectionStyle = .none
        
        setupView()
        bindViewModel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.inputs.prepareForReuse()
    }

    // MARK: - Instance Methods

    func configure(_ practiceType: PracticeType, withPracticeGroupAtIndex index: Int) -> PracticeGroupCell {
        viewModel.inputs.configure(practiceType, withPracticeGroupAtIndex: index)
        return self
    }
    
    @objc func handleHistoryButton() {
        viewModel.inputs.historyButtonTapped()
    }
    
    @objc func handlePracticeButton() {
        viewModel.inputs.practiceButtonTapped()
    }
    
    @objc func handleTimePracticeButton() {
        viewModel.inputs.timedPracticeButtonTapped()
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.title.bind(.update) { [weak self] value in
            self?.titleLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.groupImage.bind(.update) { [weak self] value in
            self?.groupImage.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.level.bind(.update) { [weak self] value in
            self?.levelLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isSelected.bind(.skipRepeat) { [weak self] value in
            self?.isSelected = value
            self?.toggleView.isHidden = !value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isLocked.bind(.skipRepeat) { [weak self] value in
            self?.lockLabel.isHidden = !value
            self?.container.alpha = value ? 0.3 : 1.0
        }.disposed(by: disposeBag)
    }
    
    // MARK: - View Properties
    
    private lazy var container: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            mainView,
            toggleView
        ])
        x.axis = .vertical
        x.distribution = .equalSpacing
        x.spacing = Theme.Size.Spacing.common
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var mainView: UIView = {
        let x = UIStackView(arrangedSubviews: [
            groupImageContainer,
            groupContainer,
        ])
        x.spacing = Theme.Size.Spacing.section
        x.alignment = .center
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalTo: groupImageContainer.heightAnchor).isActive = true
        x.addSubview(lockLabel)
        NSLayoutConstraint.activate([
            lockLabel.trailingAnchor.constraint(equalTo: x.trailingAnchor),
            lockLabel.topAnchor.constraint(equalTo: x.topAnchor),
        ])
        return x
    }()
    
    lazy var lockLabel: UIImageView = {
        let x = UIImageView()
        x.image = UIImage(named: "baseline_lock_black_24pt")
        x.tintColor = Theme.Text.Color.secondary
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var groupImageContainer: UIView = {
        let x = UIView()
        let size: CGFloat = 100
        x.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        x.layer.borderWidth = 5
        x.layer.cornerRadius = size / 2
        x.clipsToBounds = true
        x.translatesAutoresizingMaskIntoConstraints = false
        x.widthAnchor.constraint(equalToConstant: size).isActive = true
        x.heightAnchor.constraint(equalToConstant: size).isActive = true
        x.addSubview(groupImage)
        NSLayoutConstraint.activate([
            groupImage.leadingAnchor.constraint(equalTo: x.leadingAnchor),
            groupImage.trailingAnchor.constraint(equalTo: x.trailingAnchor),
            groupImage.topAnchor.constraint(equalTo: x.topAnchor),
            groupImage.bottomAnchor.constraint(equalTo: x.bottomAnchor),
        ])
        return x
    }()
    
    lazy var groupImage: UILabel = {
        let x = UILabel()
        x.text = "い"
        x.textColor = Theme.Text.Color.primary
        x.font = UIFont.systemFont(ofSize: 60, weight: .regular)
        x.textAlignment = .center
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var groupContainer: UIStackView = {
        let x = UIStackView(arrangedSubviews: [
            titleLabel,
            levelLabel,
        ])
        x.axis = .vertical
        x.spacing = Theme.Size.Spacing.common
        x.alignment = .leading
        return x
    }()
    
    lazy var titleLabel: UILabel = {
        let x = UILabel()
        x.font = .preferredFont(forTextStyle: .headline)
        return x
    }()
    
    lazy var levelLabel: UILabel = {
        let x = UILabel()
        x.textColor = Theme.Text.Color.secondary
        return x
    }()
    
    // MARK: Body
    private lazy var toggleView: UIView = {
        let x = UIStackView(arrangedSubviews: [
            historyButton,
            timePracticeButton,
            practiceButton,
        ])
        x.spacing = Theme.Size.Spacing.common
        x.alignment = .trailing
        return x
    }()
    
    lazy var historyButton: Button = {
        let x = Button(customType: .primary)
        x.setImage(UIImage(named: "baseline_history_black_36pt"), for: .normal)
        x.imageView?.contentMode = .scaleAspectFit
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        x.addTarget(self, action: #selector(handleHistoryButton), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: x.buttonHeight).isActive = true
        return x
    }()
    
    lazy var practiceButton: Button = {
        let x = Button(customType: .primaryRounded)
        x.setTitle("practice", for: .normal)
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        x.addTarget(self, action: #selector(handlePracticeButton), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: x.buttonHeight).isActive = true
        return x
    }()
    
    lazy var timePracticeButton: Button = {
        let x = Button(customType: .primaryRounded)
        x.setTitle("practice", for: .normal)
        x.setImage(UIImage(named: "baseline_timer_black_24pt"), for: .normal)
        x.imageView?.contentMode = .scaleAspectFit
        x.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
        x.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8+2, bottom: 8, right: 16+2)
        x.isEnabled = false
        x.addTarget(self, action: #selector(handleTimePracticeButton), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        x.heightAnchor.constraint(equalToConstant: x.buttonHeight).isActive = true
        return x
    }()
    
    // MARK: - Setup View
    
    private func setupView() {
        addSubview(container)
        
        let padding = Theme.Size.Padding.standard
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
        
        let stackViewBottom = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        stackViewBottom.isActive = true
        stackViewBottom.priority = .init(rawValue: 999)
    }
}
