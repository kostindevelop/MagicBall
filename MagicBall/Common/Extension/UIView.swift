//
//  UIView.swift
//  8ball
//
//  Created by Konstantin Igorevich on 13.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

extension UIView {
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 15, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 15, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
