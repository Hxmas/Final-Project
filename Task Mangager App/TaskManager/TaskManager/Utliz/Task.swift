//
//  Task.swift
//  TaskManager
//
//  Created by Hamas Mahroof on 29/04/2024.
//

import Foundation
import CoreData

@objc(Task)
public class Tasks: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
}
