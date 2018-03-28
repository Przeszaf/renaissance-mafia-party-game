//
//  Expansion+CoreDataProperties.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 27/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//
//

import Foundation
import CoreData


extension Expansion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expansion> {
        return NSFetchRequest<Expansion>(entityName: "Expansion")
    }

    @NSManaged public var name: String?
    @NSManaged public var about: String?
    @NSManaged public var matches: NSSet?

}

// MARK: Generated accessors for matches
extension Expansion {

    @objc(addMatchesObject:)
    @NSManaged public func addToMatches(_ value: Match)

    @objc(removeMatchesObject:)
    @NSManaged public func removeFromMatches(_ value: Match)

    @objc(addMatches:)
    @NSManaged public func addToMatches(_ values: NSSet)

    @objc(removeMatches:)
    @NSManaged public func removeFromMatches(_ values: NSSet)

}
