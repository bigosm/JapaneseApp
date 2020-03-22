//
//  SplashScreen.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 19/03/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public class SplashScreen: UIViewController {
    
    public class var instance: SplashScreen {
        UIStoryboard(name: "SplashScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "SplashScreen") as! SplashScreen
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    private var currentHour = Calendar.current.component(.hour, from: Date())
    lazy var dayTimeMessage: String = {
        switch self.currentHour {
        case 5...8:
            return "Good Morning,\nSunshine!"
        case 9...18:
            return "Hello,\nSweat heart!"
        case 19...21:
            return "Good Evening,\nMy Friend!"
        default:
            return "Hello there...\n\nGeneral Kenobi!"
        }
    }()
    lazy var dayTimeImage: [UIImage?] = {
        switch self.currentHour {
        case 5...8:
            return [UIImage(systemName: "sunrise.fill"),
                    UIImage(systemName: "moon.zzz.fill")]
        case 9...18:
            return [UIImage(systemName: "sun.max.fill"),
                    UIImage(systemName: "sunrise.fill")]
        case 19...21:
            return [UIImage(systemName: "sunset.fill"),
                    UIImage(systemName: "sun.max.fill")]
        default:
            return [UIImage(systemName: "moon.zzz.fill"),
                    UIImage(systemName: "sunset.fill")]
        }
        }()
    
    var dayTimeImageContainer = UIView()
    lazy var dayTimeImageView: [UIImageView] = {
        return dayTimeImage.map {
            let imageView = UIImageView()
            imageView.image = $0
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = Theme.primaryColor
            return imageView
        }
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.text = self.dayTimeMessage
        
        self.setupView()
    }
    
    public func animate(completion: @escaping () -> ()) {
        self.welcomeLabel.isHidden = false
        self.welcomeLabel.alpha = 0
        
        let degree90 = CGFloat.pi / 2

        self.dayTimeImageView[0].alpha = 0
        self.dayTimeImageView[1].alpha = 0
        
        self.view.layoutIfNeeded()

        UIView.animateKeyframes(
            withDuration: 3,
            delay: 0,
            options: .calculationModeCubicPaced,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.5) {
                    self.dayTimeImageView.forEach {
                        $0.transform = CGAffineTransform(rotationAngle: -degree90)
                    }
                    self.dayTimeImageContainer.transform = CGAffineTransform(rotationAngle: degree90)
                }

                UIView.addKeyframe(withRelativeStartTime: 1.5, relativeDuration: 1.5) {
                    self.dayTimeImageView.forEach {
                        $0.transform = CGAffineTransform(rotationAngle: -degree90 * 2)
                    }
                    self.dayTimeImageContainer.transform = CGAffineTransform(rotationAngle: degree90 * 2)
                }

        })
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .autoreverse, animations: {
            self.dayTimeImageView[1].alpha = 1
        }, completion: { finished in
            self.dayTimeImageView[1].alpha = 0
        })

        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            self.welcomeLabel.alpha = 1
            self.dayTimeImageView[0].alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 4.0, animations: {
            self.view.alpha = 0
        }, completion: { _ in
            completion()
        })
    }
    
    private func setupView() {
        self.view.addSubview(self.dayTimeImageContainer)
        
        self.dayTimeImageContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayTimeImageContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30),
            self.dayTimeImageContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.dayTimeImageContainer.widthAnchor.constraint(equalToConstant: 500),
            self.dayTimeImageContainer.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        self.dayTimeImageView.enumerated().forEach {
            self.dayTimeImageContainer.addSubview($0.element)
            
            $0.element.translatesAutoresizingMaskIntoConstraints = false
            
            switch $0.offset {
            case 0:
                NSLayoutConstraint.activate([
                    $0.element.centerXAnchor.constraint(equalTo: self.dayTimeImageContainer.centerXAnchor),
                    $0.element.bottomAnchor.constraint(equalTo: self.dayTimeImageContainer.bottomAnchor)
                ])
            case 1:
                NSLayoutConstraint.activate([
                    $0.element.centerYAnchor.constraint(equalTo: self.dayTimeImageContainer.centerYAnchor),
                    $0.element.leadingAnchor.constraint(equalTo: self.dayTimeImageContainer.leadingAnchor)
                ])
            default:
                return
            }
            
            NSLayoutConstraint.activate([
                $0.element.widthAnchor.constraint(equalToConstant: 80),
                $0.element.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
    }
    
}
