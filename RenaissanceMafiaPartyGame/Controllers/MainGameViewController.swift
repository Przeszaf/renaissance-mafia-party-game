//
//  MainGameViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    
    var mainGameView: MainGameView!
    var gameBoardView: GameBoardView!
    
    var players: [Player]!
    var chosenClasses: [GameClass]!
    var playersClasses = [Player: GameClass]()
    var visibility = [Player: [Player]]()
    var playersForMission = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainGameView = MainGameView(frame: view.frame, fillColors: [UIColor.red, UIColor.blue])
        view.addSubview(mainGameView)
        mainGameView.gameBoardView.labels[0].text = "2 Players"
        
        mainGameView.button.addTarget(self, action: #selector(showInfoButtonPressed(_:)), for: .touchUpInside)
        mainGameView.button2.addTarget(self, action: #selector(selectTeamButtonPressed(_:)), for: .touchUpInside)
        
        assignClasses()
        setVisibility()
    }
    
    
    
    
    @objc func showInfoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showInfo", sender: nil)
    }
    
    @objc func selectTeamButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "selectTeam", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showInfo"?:
            let controller = segue.destination as! ShowInfoViewController
            controller.players = players
            controller.visibility = visibility
            controller.playersClasses = playersClasses
        case "selectTeam"?:
            let controller = segue.destination as! SelectTeamViewController
            controller.players = players
            controller.playersClasses = playersClasses
            controller.numberOfPlayers = 2
        default:
            preconditionFailure("Wrong segue identifier")
        }
    }
    
    func assignClasses() {
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
            case "Knight":
                visiblePlayers = [Player]()
            case "Wizard":
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayer != player {
                        if anotherPlayerClass.name == "Knight" {
                            visiblePlayers.append(anotherPlayer)
                        }
                    }
                }
            case "Assassin", "Bandit":
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayer != player {
                        if anotherPlayerClass.name == "Bandit" || anotherPlayerClass.name == "Assassin" {
                            visiblePlayers.append(anotherPlayer)
                        }
                    }
                }
            default:
                print("Wrong class chosen!")
            }
            visibility[player] = visiblePlayers
        }
    }
}
