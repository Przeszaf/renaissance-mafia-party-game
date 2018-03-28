//
//  PlayerResult+CoreDataProperties.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 27/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//
//

import Foundation
import CoreData


extension PlayerResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerResult> {
        return NSFetchRequest<PlayerResult>(entityName: "PlayerResult")
    }

    @NSManaged public var win: Bool
    @NSManaged public var gameClass: GameClass?
    @NSManaged public var match: Match?
    @NSManaged public var player: Player?

}
