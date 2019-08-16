//
//  AnswerServices.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import Foundation


final class AnswerServices {
        
        enum Error: Swift.Error {
            case badUrl
            case badJson
            case incorrectData
            case api(error: Swift.Error)
        }
        
        private enum ApiKeys: String {
            case answer
        }
        
        enum Route {
            case get
            
            var path: String {
                switch self {
                case .get: return "magic/JSON/_"
                }
            }
            
            var hhtpMethod: String {
                switch self {
                case .get: return "GET"
                }
            }
            
            var body: [String: Any] {
                switch self {
                case .get: return [:]
                }
            }
            
            var header: [String: String] {
                return ["Content-Type": "application/json"]
            }
        }
        
    static func getAnswer(task: Route, completion: @escaping (AnswerModel?, Error?) -> Void) {
        let urlString = Base.url + task.path
        
        guard let url = URL(string: urlString) else {
            completion(nil, .badUrl)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = task.hhtpMethod
        request.allHTTPHeaderFields = task.header
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, .api(error: error))
                return
            }
            guard let jsonData = data else {
                completion(nil, .incorrectData)
                return
            }
               let answerModel = try? JSONDecoder().decode(AnswerModel.self, from: jsonData)
            DispatchQueue.main.async {
                print(jsonData.json)
                completion(answerModel, nil)
            }
        }
        task.resume()
    }
}

extension Data {
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
    }
}
