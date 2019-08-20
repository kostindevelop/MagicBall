//
//  AppDelegate.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 13.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let answersManager = AnswersManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFirstDefaultAnswers()
        return true
    }
    
    private func setupFirstDefaultAnswers() {
        if !UserDefault.shared.firstStartApplication() {
            let defaultLocalAnswers = ["Change your mind", "Just do it!"]
            for answer in defaultLocalAnswers {
                answersManager.addPersonalAnswerWith(text: answer)
            }
            UserDefault.shared.firstStartApplication(isFirst: true)
        }
    }
    
}

