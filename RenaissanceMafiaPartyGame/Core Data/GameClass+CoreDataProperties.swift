//
//  GameClass+CoreDataProperties.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 27/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//
//

import Foundation
import CoreData


extension GameClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameClass> {
        return NSFetchRequest<GameClass>(entityName: "GameClass")
    }

    @NSManaged public var about: String?
    @NSManaged public var isGood: Bool
    @NSManaged public var name: String?
    @NSManaged public var isAdditional: Bool
    @NSManaged public var results: NSSet?

}

// MARK: Generated accessors for results
extension GameClass {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: PlayerResult)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: PlayerResult)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}
