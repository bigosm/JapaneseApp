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

    private var currentHour = Calendar.current.component(.hour, from: Date())
    
    lazy var dayTimeMessage: String = {
        switch currentHour {
        case 5...9:
            return "Good Morning,\nSunshine!"
        case 10...18:
            return "Hello,\nSweat heart!"
        case 19...22:
            return "Good Evening,\nMy Friend!"
        default:
            return "Hello there...\nGeneral Kenobi!"
        }
    }()
    
    lazy var dayTimeImage: [UIImage?] = {
        switch currentHour {
        case 5...9:
            return [UIImage(systemName: "sunrise.fill"),
                    UIImage(systemName: "moon.zzz.fill")]
        case 10...18:
            return [UIImage(systemName: "sun.max.fill"),
                    UIImage(systemName: "sunrise.fill")]
        case 19...22:
            return [UIImage(systemName: "sunset.fill"),
                    UIImage(systemName: "sun.max.fill")]
        default:
            return [UIImage(systemName: "moon.zzz.fill"),
                    UIImage(systemName: "sunset.fill")]
        }
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = dayTimeMessage
        setupView()
    }
    
    public func animate(completion: @escaping () -> ()) {
        welcomeLabel.isHidden = false
        welcomeLabel.alpha = 0
        
        let degree90 = CGFloat.pi / 2

        dayTimeImageView[0].alpha = 0
//        dayTimeImageView[1].alpha = 0
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
            self.dayTimeImageView.forEach {
                $0.transform = CGAffineTransform(rotationAngle: -degree90)
            }
            self.dayTimeImageContainer.transform = CGAffineTransform(rotationAngle: degree90)
            
//            self.dayTimeImageView[1].alpha = 0.3
            
        }, completion: { _ in
            UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
                self.dayTimeImageView.forEach {
                    $0.transform = CGAffineTransform(rotationAngle: -degree90 * 2)
                }
                self.dayTimeImageContainer.transform = CGAffineTransform(rotationAngle: degree90 * 2)
                
                self.dayTimeImageView[0].alpha = 1
                self.dayTimeImageView[1].alpha = 0
            }, completion: { _ in
                UIView.animate(withDuration: 2.5, delay: 0.0, options: .curveEaseOut, animations: {
                    self.dayTimeImageView.forEach {
                        $0.transform = CGAffineTransform(rotationAngle: -degree90 * 2)
                        .concatenating(CGAffineTransform(translationX: 0, y: -10))
                        .concatenating(CGAffineTransform(scaleX: 1.05, y: 1.05))
                    }
                    
                    self.welcomeLabel.transform = CGAffineTransform(translationX: 0, y: -10)
                }, completion: { _ in
                    completion()
                })
            })
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.welcomeLabel.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: {
                    self.welcomeLabel.alpha = 0.5
                }, completion: nil)
            })
        })
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!

    lazy var dayTimeImageContainer: UIView = {
        let x = UIView()
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var dayTimeImageView: [UIImageView] = {
        let imageSize = Theme.Size.Height.screen(x568: 80)
        return dayTimeImage.map {
            let x = UIImageView()
            x.image = $0
            x.contentMode = .scaleAspectFill
            x.tintColor = Theme.primaryColor
            x.translatesAutoresizingMaskIntoConstraints = false
            x.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            x.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
            return x
        }
    }()

    private func setupView() {
        view.addSubview(dayTimeImageContainer)
        dayTimeImageContainer.addSubview(dayTimeImageView[0])
        dayTimeImageContainer.addSubview(dayTimeImageView[1])
        
        let containerSize = Theme.Size.Height.screen(x568: 600)
        NSLayoutConstraint.activate([
            dayTimeImageContainer.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: Theme.Size.Height.screen(x568: 70)),
            dayTimeImageContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayTimeImageContainer.widthAnchor.constraint(equalToConstant: containerSize),
            dayTimeImageContainer.heightAnchor.constraint(equalToConstant: containerSize)
        ])
        
        NSLayoutConstraint.activate([
            dayTimeImageView[0].centerXAnchor.constraint(equalTo: dayTimeImageContainer.centerXAnchor),
            dayTimeImageView[0].bottomAnchor.constraint(equalTo: dayTimeImageContainer.bottomAnchor),
            dayTimeImageView[1].centerYAnchor.constraint(equalTo: dayTimeImageContainer.centerYAnchor),
            dayTimeImageView[1].leadingAnchor.constraint(equalTo: dayTimeImageContainer.leadingAnchor),
        ])
    }
    
}
