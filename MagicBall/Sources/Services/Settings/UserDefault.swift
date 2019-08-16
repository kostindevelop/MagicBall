//
//  UserDefault.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import Foundation

struct DefaultKey {
    static let localAnswerSwitcher = "localAnswer"
}

class UserDefault {
    
    static let shared = UserDefault()
    
    private let defaults = UserDefaults.standard
    
    func localAnswerIsEnable(switcher: Bool) {
        self.defaults.set(switcher, forKey: DefaultKey.localAnswerSwitcher)
        self.defaults.synchronize()
    }
    
    func localAnswerIsEnable() -> Bool {
        return self.defaults.bool(forKey: DefaultKey.localAnswerSwitcher)
    }
}
