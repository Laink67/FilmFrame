//
//  UIButtonExtension.swift
//  FilmFrame
//
//  Created by иван on 21/12/2019.
//  Copyright © 2019 иван. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    func pulsate(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 3
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
    
    func transitionAnimation(animationOptions: UIView.AnimationOptions, isReset: Bool) {
        UIView.transition(with: self, duration: 1.0, options: animationOptions, animations: {}, completion: nil)
    }
}
