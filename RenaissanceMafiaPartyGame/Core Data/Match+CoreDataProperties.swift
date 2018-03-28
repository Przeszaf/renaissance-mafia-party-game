//
//  Match+CoreDataProperties.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 27/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//
//

import Foundation
import CoreData


extension Match {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Match> {
        return NSFetchRequest<Match>(entityName: "Match")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var players: NSSet?
    @NSManaged public var results: NSSet?
    @NSManaged public var expansions: NSSet?

}

// MARK: Generated accessors for players
extension Match {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Player)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Player)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

// MARK: Generated accessors for results
extension Match {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: PlayerResult)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: PlayerResult)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}

// MARK: Generated accessors for expansions
extension Match {

    @objc(addExpansionsObject:)
    @NSManaged public func addToExpansions(_ value: Expansion)

    @objc(removeExpansionsObject:)
    @NSManaged public func removeFromExpansions(_ value: Expansion)

    @objc(addExpansions:)
    @NSManaged public func addToExpansions(_ values: NSSet)

    @objc(removeExpansions:)
    @NSManaged public func removeFromExpansions(_ values: NSSet)

}
