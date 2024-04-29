//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by User on 29/04/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension Note : Identifiable {

}
