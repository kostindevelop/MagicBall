//
//  BallController.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 13.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

class BallController: BaseViewController {

    @IBOutlet weak var magicBallImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.33, animations: {
            self.view.alpha = 1
        }) { _ in
            self.magicBallImageView.shake()
        }
    }

    @IBAction func didTapSettingsButton(_ sender: UIButton) {
        show(getControllerWith(identifire: "SettingsController"), sender: nil)
    }
    
    
    @IBAction func didTouchScreen(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
}
