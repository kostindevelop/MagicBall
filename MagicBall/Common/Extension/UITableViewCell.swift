//
//  UITableViewCell.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func enable(on: Bool) {
        self.isUserInteractionEnabled = on
        for view in contentView.subviews {
            view.isUserInteractionEnabled = on
            view.alpha = on ? 1 : 0.5
        }
    }
}
