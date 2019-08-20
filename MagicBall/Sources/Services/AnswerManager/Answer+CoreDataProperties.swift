//
//  Answer+CoreDataProperties.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var text: String

}
