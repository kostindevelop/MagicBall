//
//  StartController.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 13.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

enum HiddenAnswer: Int {
    case hidden = 0
    case show = 1
}

class StartController: BaseViewController {

    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var viewAnswer: UIView!
    @IBOutlet weak var labelAnswer: UILabel!
    
    private var hiddenAnswer: HiddenAnswer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenViewAnswer(state: .hidden)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake
        {
            imgPhone.shake()
            viewAnswer.shake()
            AnswerServices.getAnswer(task: .get) { (result, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let answerModel = result else { return }
                DispatchQueue.main.async {
                    self.labelAnswer.text = answerModel.magic?.answer
                    self.hiddenViewAnswer(state: .show)
                }
            }
            
        }
    }
    
    private func configuredUI() {
        imgPhone.layer.shadowColor = UIColor(named: "white")?.cgColor
        imgPhone.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        imgPhone.layer.shadowOpacity = 1.0
        imgPhone.layer.shadowRadius = 7.0
        imgPhone.layer.masksToBounds = false
        imgPhone.transform = .init(rotationAngle: 6)
        labelAnswer.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        labelAnswer.layer.shadowRadius = 3.0
        labelAnswer.layer.shadowOpacity = 1.0
        labelAnswer.layer.shadowOffset = CGSize(width: 4, height: 4)
        labelAnswer.layer.masksToBounds = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(openSettingsScreen))
    }
    
    private func hiddenViewAnswer(state: HiddenAnswer) {
        UIView.animate(withDuration: 1, delay: 1.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: [], animations: {
            let statusAnswer = state
            switch statusAnswer {
            case .hidden:
                self.viewAnswer.alpha = 0
                self.viewAnswer.transform = CGAffineTransform(scaleX: 0, y: 0)
            case .show:
                self.viewAnswer.alpha = 1
                self.viewAnswer.transform = .identity
            default:
                print("Error hidden answer view")
            }
        }) { (_) in }
    }
    
    @objc private func openSettingsScreen() {
        navigationController?.pushViewController(getControllerWith(identifire: "SettingsController"), animated: true)
    }
}

