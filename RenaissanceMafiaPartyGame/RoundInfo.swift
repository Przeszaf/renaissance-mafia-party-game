//
//  MatchInfo.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 23/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class RoundInfo {
    var playersMissionDecision = [Player: Bool]()
    var playersQuestDecision = [Player: Bool]()
    var failedMissionsCount = 0
    var roundWin: Bool?
}
