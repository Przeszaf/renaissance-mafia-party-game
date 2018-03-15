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
    
    var players: [Player]!
    var chosenClasses: [GameClasses]!
    var playersClasses = [Player: GameClasses]()
    var visibility = [Player: [Player]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainGameView = MainGameView(frame: view.frame)
        view.addSubview(mainGameView)
        
        mainGameView.button.addTarget(self, action: #selector(showInfoButtonPressed(_:)), for: .touchUpInside)
        
        assignClasses()
        
        setVisibility()
        

    }
    
    
    
    
    @objc func showInfoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showInfo", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showInfo"?:
            let controller = segue.destination as! ShowInfoViewController
            controller.players = players
            controller.visibility = visibility
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
            switch playerClass {
            case .Knight:
                visiblePlayers = [Player]()
            case .Wizard:
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayer != player {
                        if anotherPlayerClass == .Knight {
                            visiblePlayers.append(anotherPlayer)
                        }
                    }
                }
            case .Assassin, .Bandit:
                for (anotherPlayer, anotherPlayerClass) in playersClasses {
                    if anotherPlayer != player {
                        if anotherPlayerClass == .Bandit || anotherPlayerClass == .Assassin {
                            visiblePlayers.append(anotherPlayer)
                        }
                    }
                }
            }
            visibility[player] = visiblePlayers
        }
    }
}
