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
    case show
}

class StartController: BaseViewController {

    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var viewAnswer: UIView!
    @IBOutlet weak var labelAnswer: UILabel!
    
    private var hiddenAnswer: HiddenAnswer?
    private let answersManager = AnswersManager.shared
    private var timer = Timer()
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenViewAnswer(state: .hidden)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgPhone.shake()
            viewAnswer.shake()
            generationMagicAnswer()
        }
    }
    
    private func generationMagicAnswer() {
        if UserDefault.shared.localAnswerIsEnable() {
            getRandomLocalAnswer()
        } else {
            AnswerServices.getAnswer(task: .get) { (result, error) in
                if error != nil {
                    self.getRandomLocalAnswer()
                }
                guard let answerModel = result else { return }
                DispatchQueue.main.async {
                    self.labelAnswer.text = answerModel.magic?.answer
                    self.hiddenViewAnswer(state: .show)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    private func getRandomLocalAnswer() {
        DispatchQueue.main.async {
            let localAnswers = self.answersManager.getPersonalAnswers()
            if let randomAnswer = localAnswers.randomElement()?.text {
                self.labelAnswer.text = randomAnswer
            } else {
                self.labelAnswer.text = "Stop shaking me, my head hurts"
            }
            self.hiddenViewAnswer(state: .show)
            self.view.layoutIfNeeded()
        }
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(StartController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        counter += 1
        if counter == 5 {
            timer.invalidate()
            counter = 0
            DispatchQueue.main.async {
                self.hiddenViewAnswer(state: .hidden)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func configuredUI() {
        hiddenViewAnswer(state: .hidden)
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
                self.viewAnswer.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            case .show:
                self.viewAnswer.alpha = 1
                self.viewAnswer.transform = .identity
                self.runTimer()
            }
        }) { (_) in }
    }
    
    @objc private func openSettingsScreen() {
        navigationController?.pushViewController(getControllerWith(identifire: "SettingsController"), animated: true)
    }
}

