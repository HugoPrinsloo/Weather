//
//  SplashScreenViewController.swift
//  Weather
//
//  Created by Hugo Prinsloo on 2018/01/30.
//  Copyright © 2018 Over. All rights reserved.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {
    
    let label: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Helvetica Neue", size: 28)
        l.textColor = .white
        l.text = "weather"
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .black
        
        let animationView = LOTAnimationView(name: "world_locations", bundle: Bundle(for: SplashScreenViewController.self))
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -175).isActive = true

        animationView.loopAnimation = false
                

        animationView.play { [weak self] _ in
            let vc = CitySelectionViewController()
            let navigationController = UINavigationController(rootViewController: vc)
            self?.present(navigationController, animated: true, completion: nil)
        }
        
    }

}
