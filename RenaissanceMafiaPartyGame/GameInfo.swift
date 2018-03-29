//
//  GameInf.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 23/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class GameInfo {
    var currentLeader: Player!
    var players = [Player]()
    var classes = [GameClass]()
    var playersClasses = [Player: GameClass]()
    var visibility = [Player: [Player]]()
    var expansions = [Expansion]()
    var rounds = [RoundInfo]()
    var magicMirrorOwner: Player!
    var playersInTeam = [Int]()
    var failuresToLose = [Int]()
    var evilClassesCount = 0
    var goodClassesCount = 0
    
    func assignClasses() {
        var chosenClasses = classes
        for player in players {
            let randomNumber = Int(arc4random_uniform(UInt32(chosenClasses.count)))
            playersClasses[player] = chosenClasses[randomNumber]
            chosenClasses.remove(at: randomNumber)
        }
    }
    
    func setVisibility() {
        for player in players {
            var visiblePlayers = [Player]()
            guard let playerClass = playersClasses[player] else { return }
            switch playerClass.name! {
            case "Knight", "Outcast":
                visiblePlayers = [Player]()
            case "Wizard":
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayer != player {
                        if anotherPlayerClass.name == "Knight" {
                            visiblePlayers.append(anotherPlayer)
                        }
                    }
                }
            case "Assassin", "Bandit", "Warlock":
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayer != player {
                        if anotherPlayerClass.name == "Bandit" || anotherPlayerClass.name == "Assassin" || anotherPlayerClass.name == "Warlock" {
                            visiblePlayers.append(anotherPlayer)
                        }
                    }
                }
            case "Psychic":
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayerClass.name == "Wizard" || anotherPlayerClass.name == "Warlock" {
                        visiblePlayers.append(anotherPlayer)
                    }
                }
            default:
                print("Wrong class chosen!")
            }
            visibility[player] = visiblePlayers
        }
    }
    
    
    func assignFirstLeader() {
        currentLeader = players[Int(arc4random_uniform(UInt32(players.count)))]
    }
    
    func nextLeader() {
        guard let index = players.index(of: currentLeader) else { return }
        if index + 1 < players.count {
            currentLeader = players[index + 1]
        } else {
            currentLeader = players[0]
        }
    }
    
    func setPlayersInRound() {
        for i in 0..<5 {
            var playersInRound = 0
            var failsInRound = 0
            switch players.count {
            case 5:
                failsInRound = 1
                switch i {
                case 0:
                    playersInRound = 2
                case 1:
                    playersInRound = 3
                case 2:
                    playersInRound = 2
                case 3:
                    playersInRound = 3
                case 4:
                    playersInRound = 3
                default:
                    playersInRound = 0
                }
            case 6:
                failsInRound = 1
                switch i {
                case 0:
                    playersInRound = 2
                case 1:
                    playersInRound = 3
                case 2:
                    playersInRound = 3
                case 3:
                    playersInRound = 4
                case 4:
                    playersInRound = 4
                default:
                    playersInRound = 0
                }
            case 7:
                failsInRound = 1
                switch i {
                case 0:
                    playersInRound = 2
                case 1:
                    playersInRound = 3
                case 2:
                    playersInRound = 3
                case 3:
                    playersInRound = 4
                case 4:
                    playersInRound = 4
                default:
                    playersInRound = 0
                }
            case 8:
                failsInRound = 1
                switch i {
                case 0:
                    playersInRound = 2
                case 1:
                    playersInRound = 3
                case 2:
                    playersInRound = 3
                case 3:
                    playersInRound = 3
                case 4:
                    playersInRound = 3
                default:
                    playersInRound = 0
                }
            case 9:
                failsInRound = 1
                switch i {
                case 0:
                    playersInRound = 2
                case 1:
                    playersInRound = 3
                case 2:
                    playersInRound = 3
                case 3:
                    playersInRound = 3
                case 4:
                    playersInRound = 3
                default:
                    playersInRound = 0
                }
            case 10:
                failsInRound = 1
                switch i {
                case 0:
                    playersInRound = 2
                case 1:
                    playersInRound = 3
                case 2:
                    playersInRound = 3
                case 3:
                    playersInRound = 3
                case 4:
                    playersInRound = 3
                default:
                    playersInRound = 0
                }
            default:
                playersInRound = 0
                failsInRound = 0
            }
            playersInTeam.append(playersInRound)
            failuresToLose.append(failsInRound)
        }
    }
    
    func setClassesCount() {
        switch players.count {
        case 5:
            goodClassesCount = 3
            evilClassesCount = 2
        case 6:
            goodClassesCount = 4
            evilClassesCount = 2
        case 7:
            goodClassesCount = 4
            evilClassesCount = 3
        case 8:
            goodClassesCount = 5
            evilClassesCount = 3
        case 9:
            goodClassesCount = 5
            evilClassesCount = 4
        case 10:
            goodClassesCount = 6
            evilClassesCount = 4
        default:
            goodClassesCount = 0
            evilClassesCount = 0
        }
    }
}
