//
//  AnswerModel.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import Foundation

// MARK: - AnswerModel
struct AnswerModel: Codable {
    let magic: Magic?
    
    enum CodingKeys: String, CodingKey {
        case magic = "magic"
    }
}

// MARK: - Magic
struct Magic: Codable {
    let question: String?
    let answer: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case question = "question"
        case answer = "answer"
        case type = "type"
    }
}
