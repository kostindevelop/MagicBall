//
//  StartController.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 13.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

class StartController: BaseViewController {

    @IBOutlet weak var imgPhone: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake
        {
            imgPhone.shake()
        }
    }
    
    private func configuredUI() {
        imgPhone.layer.shadowColor = UIColor(named: "white")?.cgColor
        imgPhone.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        imgPhone.layer.shadowOpacity = 1.0
        imgPhone.layer.shadowRadius = 7.0
        imgPhone.layer.masksToBounds = false
        imgPhone.transform = .init(rotationAngle: 6)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(openSettingsScreen))
    }
    
    @objc private func openSettingsScreen() {
        navigationController?.pushViewController(getControllerWith(identifire: "SettingsController"), animated: true)
    }
}

