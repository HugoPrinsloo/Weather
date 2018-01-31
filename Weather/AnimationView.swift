//
//  File.swift
//  Weather
//
//  Created by Hugo Prinsloo on 2018/01/30.
//  Copyright © 2018 Over. All rights reserved.
//

import Foundation
import UIKit
import Lottie

@IBDesignable
class AnimationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        let animationView = LOTAnimationView(name: "floating_cloud", bundle: Bundle(for: AnimationView.self))
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        addSubview(animationView)
        
        animationView.play()
        animationView.loopAnimation = false
        
        
        
    }
}
