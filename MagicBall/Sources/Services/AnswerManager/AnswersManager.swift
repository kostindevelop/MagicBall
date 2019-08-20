//
//  AnswerManager.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit
import CoreData

final class AnswersManager {
    
    private init() {}
    static let shared = AnswersManager()
    
    // MARK - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalAnswers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("save successfully")
                
                
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }
    
    // MARK: - Personal Answers Method Manger
    
    func addPersonalAnswerWith(text: String) {
        let newAnswer = Answer(context: self.context)
        newAnswer.text = text
        save()
    }
    
    func getPersonalAnswers() -> [Answer] {
        let answers = self.fetch(Answer.self)
        return answers
    }
    
    func delete(answer: NSManagedObject) {
        context.delete(answer)
        save()
    }
    
}
